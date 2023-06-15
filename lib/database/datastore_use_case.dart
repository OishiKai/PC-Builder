import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataStoreUseCase {
  static final Future<Database> database = openDatabase(
    join(getDatabasesPath().toString(), 'custom_pc_database.db'),
    // マイグレーション
    onCreate: (db, version) {
      db.execute('PRAGMA foreign_keys = ON');
      // カスタムテーブル
      db.execute(
        '''CREATE TABLE custom (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        price TEXT NOT NULL,
        cpu_id INTEGER,
        cpuCooler_id INTEGER,
        memory_id INTEGER,
        motherboard_id INTEGER,
        graphicCard_id INTEGER,
        ssd_id INTEGER,
        pc_case_id INTEGER,
        power_unit_id INTEGER,
        case_fan_id INTEGER
        compatibility_id TEXT NOT NULL,)''',
      );
      // パーツテーブル
      db.execute(
        '''CREATE TABLE pc_parts (
        id INTEGER
        custom_id TEXT,
        maker TEXT NOT NULL,
        is_new INTEGER NOT NULL,
        title TEXT NOT NULL,
        star INTEGER,evaluation TEXT,
        price TEXT NOT NULL,ranked TEXT NOT NULL,
        image TEXT NOT NULL,
        detail_url TEXT NOT NULL,
        PRIMARY KEY (id, custom_id),
        FOREIGN KEY (custom_id) REFERENCES custom(id) ON DELETE CASCADE)''',
      );
      // 店情報テーブル
      db.execute(
        '''CREATE TABLE parts_shops (
        id INTEGER,
        parts_id INTEGER,
        rank TEXT NOT NULL,
        price INTEGER NOT NULL,
        best_price_diff TEXT NOT NULL,
        name TEXT,pageUrl TEXT NOT NULL,
        PRIMARY KEY (id, custom_id),
        FOREIGN KEY (custom_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
      // スペック情報テーブル
      db.execute(
        '''CREATE TABLE parts_specs (
        id INTEGER,
        parts_id INTEGER
        spec_name TEXT NOT NULL,
        spec_value TEXT,
        PRIMARY KEY (id, custom_id),
        FOREIGN KEY (custom_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
      // 画像テーブル
      db.execute(
        '''CREATE TABLE full_scale_images (
        id INTEGER,
        parts_id INTEGER
        image_url TEXT NOT NULL,
        PRIMARY KEY (id, custom_id),
        FOREIGN KEY (custom_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
    },
    version: 1,
  );
}
