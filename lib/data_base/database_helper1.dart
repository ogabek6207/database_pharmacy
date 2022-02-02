import 'dart:async';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  //COLUMN
  final String tableProduct = 'tableProduct';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnImage = 'image';
  final String columnPrice = 'price';
  final String columnBasePrice = 'base_price';
  final String columnDescription = 'description';
  final String columnCount = 'card_count';

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'login.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    // user
    await db.execute(
      'CREATE TABLE $tableProduct('
      '$columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$columnName TEXT, '
      '$columnImage TEXT, '
      '$columnPrice REAl,'
      '$columnDescription TEXT,'
      '$columnCount INTEGER,'
      '$columnBasePrice REAl)',
    );
  }

  //user save
  Future<int> saveProduct(DrugsResult item) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      tableProduct,
      item.toJson(),
    );
    return result;
  }

  //user get
  Future<List<DrugsResult>> getProduct() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableProduct');
    List<DrugsResult> products = <DrugsResult>[];
    for (int i = 0; i < list.length; DrugsResult) {
      var items = DrugsResult(
        id: list[i][columnId],
        name: list[i][columnName],
        image: list[i][columnImage],
        price: list[i][columnPrice],
        basePrice: list[i][columnBasePrice],
        cardCount: list[i][columnCount],
        description: list[i][columnDescription],
      );
      products.add(items);
    }
    return products;
  }

  //user update
  Future<int> updateProduct(DrugsResult item) async {
    var dbClient = await db;
    return await dbClient.update(
      tableProduct,
      item.toJson(),
      where: "$columnId = ?",
      whereArgs: [item.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableProduct,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
