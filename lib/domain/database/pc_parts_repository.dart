import 'package:custom_pc/models/pc_parts.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/parts_category.dart';
import '../../models/parts_shop.dart';
import 'datastore_use_case.dart';

class PcPartsRepository {
  // PcParts保存
  static Future<int> insertPcParts(PcParts pcParts, String customId) async {
    final map = {
      'custom_id': customId,
      'maker': pcParts.maker,
      'is_new': pcParts.isNew ? 1 : 0,
      'title': pcParts.title,
      'star': pcParts.star,
      'evaluation': pcParts.evaluation,
      'price': pcParts.price,
      'ranked': pcParts.ranked,
      'image': pcParts.image,
      'detail_url': pcParts.detailUrl,
      'category': pcParts.category?.categoryName,
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

  // 画像情報保存
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
  static Future<List<PcParts>> getAllPcParts() async {
    final Database db = await DataStoreUseCase.database;
    final List<Map<String, dynamic>> maps = await db.query('pc_parts');
    final List<PcParts> pcParts = [];
    for (var map in maps) {
      // 店、スペック、画像情報取得
      final List<PartsShop> shops = await _selectPartsShopsById(map['id']);
      final Map<String, String?> specs = await _partsSpecs(map['id']);
      final List<String> images = await _selectFullScaleImagesById(map['id']);
      // PcPartsオブジェクト化

      var parts = PcParts(
        maker: map['maker'],
        isNew: map['is_new'] == 1 ? true : false,
        title: map['title'],
        star: map['star'],
        evaluation: map['evaluation'],
        price: map['price'],
        ranked: map['ranked'],
        image: map['image'],
        detailUrl: map['detail_url'],
        shops: shops,
        specs: specs,
        fullScaleImages: images,
      );
      if (map['category'] != null) {
        parts = parts.copyWith(category: PartsCategory.fromCategoryName(map['category']));
      }
      pcParts.add(parts);
    }
    return pcParts;
  }

  static Future<PcParts?> selectPcPartsById(int? id, PartsCategory category) async {
    if (id == null) return null;
    final Database db = await DataStoreUseCase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pc_parts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    final List<PartsShop> shops = await _selectPartsShopsById(maps[0]['id']);
    final Map<String, String?> specs = await _partsSpecs(maps[0]['id']);
    final List<String> images = await _selectFullScaleImagesById(maps[0]['id']);
    final i = PcParts(
      maker: maps[0]['maker'],
      isNew: maps[0]['is_new'] == 1 ? true : false,
      title: maps[0]['title'],
      star: maps[0]['star'],
      evaluation: maps[0]['evaluation'],
      price: maps[0]['price'],
      ranked: maps[0]['ranked'],
      image: maps[0]['image'],
      detailUrl: maps[0]['detail_url'],
      shops: shops,
      specs: specs,
      fullScaleImages: images,
      category: category,
    );
    return i;
  }

  // 削除
  static Future<void> deletePcParts(int id) async {
    final Database db = await DataStoreUseCase.database;
    await _deletePartsShops(id);
    await _deletePartsSpecs(id);
    await _deleteFullScaleImages(id);
    await db.delete(
      'pc_parts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 店情報取得
  static Future<List<PartsShop>> _selectPartsShopsById(int id) async {
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

  //　店情報削除
  static Future<void> _deletePartsShops(int id) async {
    final Database db = await DataStoreUseCase.database;
    await db.delete(
      'parts_shops',
      where: 'parts_id = ?',
      whereArgs: [id],
    );
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

  // スペック情報削除
  static Future<void> _deletePartsSpecs(int id) async {
    final Database db = await DataStoreUseCase.database;
    await db.delete(
      'parts_specs',
      where: 'parts_id = ?',
      whereArgs: [id],
    );
  }

  // 画像情報取得
  static Future<List<String>> _selectFullScaleImagesById(int id) async {
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

  // 画像情報削除
  static Future<void> _deleteFullScaleImages(int id) async {
    final Database db = await DataStoreUseCase.database;
    await db.delete(
      'full_scale_images',
      where: 'parts_id = ?',
      whereArgs: [id],
    );
  }
}
