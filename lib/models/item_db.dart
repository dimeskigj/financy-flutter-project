import 'package:financy/models/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'enums/item_type.dart';

class ItemDatabase {
  ItemDatabase._internal();

  static final ItemDatabase _instance = ItemDatabase._internal();

  static Database? _db;

  factory ItemDatabase() {
    return _instance;
  }

  static Future<Database?> getDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'item_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE itemsDb(id INTEGER PRIMARY KEY, title TEXT, description TEXT, dateTime TEXT, amount REAL, longitude REAL, latitude REAL, itemType INTEGER)');
      },
      version: 1,
    );
    return _db;
  }

  static Future<int> insertItem(Item item) async {
    final database = await getDatabase();
    return await database!.insert('itemsDb', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Item>> findAll() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> maps = await database!.query('itemsDb', orderBy: 'dateTime DESC');
    return generateList(maps);
  }

  static Future<List<Item>> findAllBy(ItemType itemType, {String? sortBy = 'dateTime DESC'}) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await database!.query('itemsDb', where: 'itemType = ?', whereArgs: [itemType.index], orderBy: sortBy);
    return generateList(maps);
  }

  static Future<int> delete(int id) async {
    final database = await getDatabase();
    return await database!.delete('itemsDb', where: 'id = ?', whereArgs: [id]);
  }

  static List<Item> generateList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (index) {
      return Item(
        id: maps[index]['id'] as int,
        amount: maps[index]['amount'] as double,
        title: maps[index]['title'] as String,
        description: maps[index]['description'] as String,
        longitude: maps[index]['longitude'] as double,
        latitude: maps[index]['latitude'] as double,
        itemType: ItemType.values[maps[index]['itemType'] as int],
        dateTime: DateTime.parse(maps[index]['dateTime'] as String),
      );
    });
  }
}
