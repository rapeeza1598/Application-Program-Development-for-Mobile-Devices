import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'myDb.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, type_code TEXT)');
    await db.execute(
        'CREATE TABLE product (product_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category_id INTEGER, price INTEGER,stock INTEGER,remain INTEGER,time TEXT)');
  }

  Future<List<Map<String, dynamic>>> getCategory() async {
    final db = await database;
    var res = await db.query('category');
    return res;
  }

  insertCategory(String name) async {
    final db = await database;
    await db.insert('category', {'type_code': name});
  }

  deleteCategory(int id) async {
    final db = await database;
    await db.delete('category', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    final db = await database;
    var res = await db.query('product');
    return res;
  }

  // get 5 product that remain is low
  Future<List<Map<String, dynamic>>> getLowRemain() async {
    final db = await database;
    var res = await db.query('product', where: 'remain < 10', limit: 5);
    return res;
  }

  // get 3 product that highest price
  Future<List<Map<String, dynamic>>> getHighestPrice() async {
    final db = await database;
    var res = await db.query('product', orderBy: 'price DESC', limit: 3);
    return res;
  }

  // get product by category
  Future<List<Map<String, dynamic>>> getProductByCategory(
      String category) async {
    final db = await database;
    var res = await db
        .query('product', where: 'category_id = ?', whereArgs: [category]);
    return res;
  }

  insertProduct(
    String name,
    String category,
    int price,
    int stock,
    int remain,
  ) async {
    final db = await database;
    await db.insert('product', {
      'name': name,
      'category_id': category,
      'price': price,
      'stock': stock,
      'remain': remain,
      'time': DateTime.now().toString()
    });
  }

  void deleteProduct(product) {
    final db = database;
    db.then((value) {
      value.delete('product', where: 'product_id = ?', whereArgs: [product]);
    });
  }

  void updateCategory(category, String text) {
    final db = database;
    db.then((value) {
      value.update('category', {'type_code': text},
          where: 'id = ?', whereArgs: [category]);
    });
  }
}
