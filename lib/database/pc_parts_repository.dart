import 'package:custom_pc/models/pc_parts.dart';
import 'package:sqflite/sqflite.dart';

import '../models/parts_shop.dart';
import 'datastore_use_case.dart';

class PcPartsRepository {
  // PcParts保存
  static Future<int> insertPcParts(PcParts pcParts, String id) async {
    final map = {
      'custom_id': id,
      'maker': pcParts.maker,
      'is_new': pcParts.isNew ? 1 : 0,
      'title': pcParts.title,
      'star': pcParts.star,
      'evaluation': pcParts.evaluation,
      'price': pcParts.price,
      'ranked': pcParts.ranked,
      'image': pcParts.image,
      'detail_url': pcParts.detailUrl,
    };
    final Database db = await DataStoreUseCase.database;
    final partsId = await db.insert(
      'pc_parts',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // 店情報、スペック情報、画像情報を保存
    await _insertPartsShops(pcParts.shops, partsId);
    await _insertPartsSpecs(pcParts.specs, partsId);
    await _insertFullScaleImages(pcParts.fullScaleImages, partsId);
    return partsId;
  }

  // 店情報保存
  static Future<void> _insertPartsShops(List<PartsShop>? shops, int id) async {
    if (shops == null) return;
    final Database db = await DataStoreUseCase.database;
    for (var shop in shops) {
      final map = {
        'parts_id': id,
        'rank': shop.rank,
        'price': shop.price,
        'best_price_diff': shop.bestPriceDiff,
        'name': shop.shopName,
        'page_url': shop.shopPageUrl,
      };
      await db.insert(
        'parts_shops',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // スペック情報保存
  static Future<void> _insertPartsSpecs(Map<String, String?>? specs, int id) async {
    if (specs == null) return;
    final Database db = await DataStoreUseCase.database;
    specs.forEach((key, value) async {
      final map = {
        'parts_id': id,
        'spec_name': key,
        'spec_value': value,
      };
      await db.insert(
        'parts_specs',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  static Future<void> _insertFullScaleImages(List<String>? images, int id) async {
    if (images == null) return;
    final Database db = await DataStoreUseCase.database;
    for (var image in images) {
      final map = {
        'parts_id': id,
        'image_url': image,
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
    final Database db = await DataStoreUseCase.database;
    final List<Map<String, dynamic>> maps = await db.query('pc_parts');
    final List<PcParts> pcParts = [];
    for (var map in maps) {
      final List<PartsShop> shops = await _partsShops(map['id']);
      final Map<String, String?> specs = await _partsSpecs(map['id']);
      final List<String> images = await _fullScaleImages(map['id']);
      pcParts.add(PcParts(
        maker: map['maker'],
        isNew: map['is_new'] == 1 ? true : false,
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
  static Future<List<PartsShop>> _partsShops(int id) async {
    final Database db = await DataStoreUseCase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parts_shops',
      where: 'parts_id = ?',
      whereArgs: [id],
    );
    final List<PartsShop> shops = [];
    for (var map in maps) {
      shops.add(PartsShop(
        map['rank'],
        map['price'],
        map['best_price_diff'],
        map['name'],
        map['page_url'],
      ));
    }
    return shops;
  }

  // スペック情報取得
  static Future<Map<String, String?>> _partsSpecs(int id) async {
    final Database db = await DataStoreUseCase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parts_specs',
      where: 'parts_id = ?',
      whereArgs: [id],
    );
    final Map<String, String?> specs = {};
    for (var map in maps) {
      specs[map['spec_name']] = map['spec_value'];
    }
    return specs;
  }

  // 画像情報取得
  static Future<List<String>> _fullScaleImages(int id) async {
    final Database db = await DataStoreUseCase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'full_scale_images',
      where: 'parts_id = ?',
      whereArgs: [id],
    );
    final List<String> images = [];
    for (var map in maps) {
      images.add(map['image_url']);
    }
    return images;
  }
}
