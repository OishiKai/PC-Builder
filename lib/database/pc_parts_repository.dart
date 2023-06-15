import 'package:custom_pc/models/pc_parts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../models/parts_shop.dart';


class PcPartsRepository {
  static final Future<Database> database = openDatabase(
    join(getDatabasesPath().toString(), 'custom_pc_database.db'),
    onCreate: (db, version) {
      // マイグレーション
      db.execute('PRAGMA foreign_keys = ON');
      db.execute(
        'CREATE TABLE pc_parts (id TEXT PRIMARY KEY,maker TEXT NOT NULL,isNew INTEGER NOT NULL,title TEXT NOT NULL,star INTEGER,evaluation TEXT,price TEXT NOT NULL,ranked TEXT NOT NULL,image TEXT NOT NULL,detailUrl TEXT NOT NULL)',
      );
      db.execute(
        'CREATE TABLE parts_shops (id INTEGER,custom_id TEXT ,rank TEXT NOT NULL,price INTEGER NOT NULL,bestPriceDiff TEXT NOT NULL,name TEXT,pageUrl TEXT NOT NULL,PRIMARY KEY (id, custom_id),FOREIGN KEY (custom_id) REFERENCES pc_parts(id) ON DELETE CASCADE)',
      );
      db.execute(
        'CREATE TABLE parts_specs (id INTEGER,custom_id TEXT ,specName TEXT NOT NULL,specValue TEXT,PRIMARY KEY (id, custom_id),FOREIGN KEY (custom_id) REFERENCES pc_parts(id) ON DELETE CASCADE)',
      );
      db.execute(
        'CREATE TABLE full_scale_images (id INTEGER,custom_id TEXT ,imageUrl TEXT NOT NULL,PRIMARY KEY (id, custom_id),FOREIGN KEY (custom_id) REFERENCES pc_parts(id) ON DELETE CASCADE)',
      );
    },
    version: 1,
  );

  // PcParts保存
  static Future<void> insertPcParts(PcParts pcParts) async {
    // idを生成
    final id = const Uuid().v4();
    // 店情報、スペック情報、画像情報を保存
    await _insertPartsShops(pcParts.shops, id);
    await _insertPartsSpecs(pcParts.specs, id);
    await _insertFullScaleImages(pcParts.fullScaleImages, id);
    final map = {
      'id': id,
      'maker': pcParts.maker,
      'isNew': pcParts.isNew ? 1 : 0,
      'title': pcParts.title,
      'star': pcParts.star,
      'evaluation': pcParts.evaluation,
      'price': pcParts.price,
      'ranked': pcParts.ranked,
      'image': pcParts.image,
      'detailUrl': pcParts.detailUrl,
    };
    final Database db = await database;
    await db.insert(
      'pc_parts',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 店情報保存
  static Future<void> _insertPartsShops(List<PartsShop>? shops, String id) async {
    if (shops == null) return;
    final Database db = await database;
    for (var shop in shops) {
      final map = {
        'custom_id': id,
        'rank': shop.rank,
        'price': shop.price,
        'bestPriceDiff': shop.bestPriceDiff,
        'name': shop.shopName,
        'pageUrl': shop.shopPageUrl,
      };
      await db.insert(
        'parts_shops',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // スペック情報保存
  static Future<void> _insertPartsSpecs(Map<String, String?>? specs, String id) async {
    if (specs == null) return;
    final Database db = await database;
    specs.forEach((key, value) async {
      final map = {
        'custom_id': id,
        'specName': key,
        'specValue': value,
      };
      await db.insert(
        'parts_specs',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  static Future<void> _insertFullScaleImages(List<String>? images, String id) async {
    if (images == null) return;
    final Database db = await database;
    for (var image in images) {
      final map = {
        'custom_id': id,
        'imageUrl': image,
      };
      await db.insert(
        'full_scale_images',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // PcParts取得  
  static Future<List<PcParts>> pcParts() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pc_parts');
    final List<PcParts> pcParts = [];
    for (var map in maps) {
      final List<PartsShop> shops = await _partsShops(map['id']);
      final Map<String, String?> specs = await _partsSpecs(map['id']);
      final List<String> images = await _fullScaleImages(map['id']);
      pcParts.add(PcParts(
        maker: map['maker'],
        isNew: map['isNew'] == 1 ? true : false,
        title: map['title'],
        star: map['star'],
        evaluation: map['evaluation'],
        price: map['price'],
        ranked: map['ranked'],
        image: map['image'],
        detailUrl: map['detailUrl'],
        shops: shops,
        specs: specs,
        fullScaleImages: images,
      ));
    }
    return pcParts;
  }

  // 店情報取得
  static Future<List<PartsShop>> _partsShops(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parts_shops',
      where: 'custom_id = ?',
      whereArgs: [id],
    );
    final List<PartsShop> shops = [];
    for (var map in maps) {
      shops.add(PartsShop(
        map['rank'],
        map['price'],
        map['bestPriceDiff'],
        map['name'],
        map['pageUrl'],
      ));
    }
    return shops;
  }

  // スペック情報取得
  static Future<Map<String, String?>> _partsSpecs(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parts_specs',
      where: 'custom_id = ?',
      whereArgs: [id],
    );
    final Map<String, String?> specs = {};
    for (var map in maps) {
      specs[map['specName']] = map['specValue'];
    }
    return specs;
  }

  // 画像情報取得
  static Future<List<String>> _fullScaleImages(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'full_scale_images',
      where: 'custom_id = ?',
      whereArgs: [id],
    );
    final List<String> images = [];
    for (var map in maps) {
      images.add(map['imageUrl']);
    }
    return images;
  }
}