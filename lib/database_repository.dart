import 'package:custom_pc/models/pc_parts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseRepository {
  static final Future<Database> database = openDatabase(
    join(getDatabasesPath().toString(), 'custom_pc_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE pc_parts (id INTEGER PRIMARY KEY AUTOINCREMENT,maker TEXT NOT NULL,isNew INTEGER NOT NULL,title TEXT NOT NULL,star INTEGER,evaluation TEXT,price TEXT NOT NULL,ranked TEXT NOT NULL,image TEXT NOT NULL,detailUrl TEXT NOT NULL)',
      );
    },
    version: 1,
  );

  static Future<void> insertPcParts(PcParts pcParts) async {
    final map = {
      'maker': pcParts.maker,
      'isNew': pcParts.isNew,
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

  static Future<List<PcParts>> pcParts() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pc_parts');
    return List.generate(maps.length, (i) {
      return PcParts(
        maker: maps[i]['maker'],
        isNew: maps[i]['isNew'] == 1 ? true : false,
        title: maps[i]['title'],
        star: maps[i]['star'],
        evaluation: maps[i]['evaluation'],
        price: maps[i]['price'],
        ranked: maps[i]['ranked'],
        image: maps[i]['image'],
        detailUrl: maps[i]['detailUrl'],
      );
    });
  }
}