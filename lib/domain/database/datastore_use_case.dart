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
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        cpu_id INTEGER,
        cpu_cooler_id INTEGER,
        memory_id INTEGER,
        mother_board_id INTEGER,
        graphics_card_id INTEGER,
        ssd_id INTEGER,
        pc_case_id INTEGER,
        power_unit_id INTEGER,
        case_fan_id INTEGER,
        date TEXT NOT NULL
        )''',
      );
      // パーツテーブル
      db.execute(
        '''CREATE TABLE pc_parts (
        id INTEGER PRIMARY KEY,
        custom_id TEXT,
        maker TEXT NOT NULL,
        is_new INTEGER NOT NULL,
        title TEXT NOT NULL,
        star INTEGER,evaluation TEXT,
        price TEXT NOT NULL,ranked TEXT NOT NULL,
        image TEXT NOT NULL,
        detail_url TEXT NOT NULL,
        category TEXT,
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
        name TEXT,
        page_url TEXT NOT NULL,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
      // スペック情報テーブル
      db.execute(
        '''CREATE TABLE parts_specs (
        id INTEGER,
        parts_id INTEGER,
        spec_name TEXT NOT NULL,
        spec_value TEXT,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
      // 画像テーブル
      db.execute(
        '''CREATE TABLE full_scale_images (
        id INTEGER,
        parts_id INTEGER,
        image_url TEXT NOT NULL,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
    },
    version: 1,
  );

  static final Future<Database> databaseV2 = openDatabase(
    join(getDatabasesPath().toString(), 'custom_pc_v2_database.db'),
    onCreate: (db, version) {
      db.execute('PRAGMA foreign_keys = ON');
      // カスタムテーブル
      db.execute(
        '''CREATE TABLE custom (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        date TEXT NOT NULL
        )''',
      );
      // パーツテーブル
      db.execute(
        '''CREATE TABLE pc_parts (
        id INTEGER PRIMARY KEY,
        custom_id TEXT NOT NULL,
        category TEXT NOT NULL,
        maker TEXT NOT NULL,
        is_new INTEGER NOT NULL,
        title TEXT NOT NULL,
        star INTEGER,evaluation TEXT,
        price TEXT NOT NULL,
        ranked TEXT NOT NULL,
        image TEXT NOT NULL,
        detail_url TEXT NOT NULL,
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
        name TEXT,
        page_url TEXT NOT NULL,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
      // スペック情報テーブル
      db.execute(
        '''CREATE TABLE parts_specs (
        id INTEGER,
        parts_id INTEGER,
        spec_name TEXT NOT NULL,
        spec_value TEXT,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
      // 画像テーブル
      db.execute(
        '''CREATE TABLE full_scale_images (
        id INTEGER,
        parts_id INTEGER,
        image_url TEXT NOT NULL,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
    },
    version: 1,
  );
}
