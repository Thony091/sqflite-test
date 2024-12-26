import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  Database? _database;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id TEXT PRIMARY KEY,
            name TEXT,
            price REAL
          )
        ''');
      },
    );
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete('products'); // Limpia datos antiguos
      for (final product in products) {
        await txn.insert('products', product.toJson());
      }
    });
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final db = await database;
    final result = await db.query('products');
    return result.map((json) => ProductModel.fromJson(json)).toList();
  }
}
