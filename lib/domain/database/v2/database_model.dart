import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseModel {
  static final Future<Database> database = openDatabase(
    join(getDatabasesPath().toString(), 'custom_pc_database.db'),
    // マイグレーション
    onCreate: (db, version) {
      db.execute('PRAGMA foreign_keys = ON');
      // カスタムテーブル
      db.execute(
        '''CREATE TABLE custom_v2 (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        parts_ids TEXT NOT NULL,
        date TEXT NOT NULL
        )''',
      );
      // パーツテーブル
      db.execute(
        '''CREATE TABLE pc_parts_v2 (
        id TEXT PRIMARY KEY,
        category TEXT NOT NULL,
        maker TEXT NOT NULL,
        is_new INTEGER NOT NULL,
        title TEXT NOT NULL,
        star INTEGER,
        evaluation TEXT,
        price TEXT NOT NULL,
        ranked TEXT NOT NULL,
        image TEXT NOT NULL,
        full_scale_image_count INTEGER NOT NULL,
        is_favorite INTEGER NOT NULL,
        )''',
      );
      // 店情報テーブル
      db.execute(
        '''CREATE TABLE parts_shops_v2 (
        id INTEGER,
        parts_id TEXT PRIMARY KEY,
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
        '''CREATE TABLE parts_specs_v2 (
        id INTEGER,
        parts_id TEXT PRIMARY KEY,
        spec_name TEXT NOT NULL,
        spec_value TEXT,
        PRIMARY KEY (id, parts_id),
        FOREIGN KEY (parts_id) REFERENCES pc_parts(id) ON DELETE CASCADE)''',
      );
    },
    version: 1,
  );
}
