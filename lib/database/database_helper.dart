import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vendus/models/user.dart';
import 'package:vendus/models/product.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database does not exist, create it
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), 'vendus_database.db');
    print(getDatabasesPath());
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Create the 'users' table
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        userName TEXT,
        password TEXT,
        email TEXT,
        phoneNumber TEXT,
        role TEXT
      )
    ''');

    // Create the 'products' table
    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        userId TEXT,  -- Foreign key referencing the user who owns the product
        productName TEXT,
        unitOfMeasurement TEXT,
        quantity REAL,
        cost REAL,
        dateOfPurchase TEXT,
        description TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('products', product.toMap());
  }

  Future<bool> isUsernamePasswordCombinationExists(String username, String password) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM users WHERE userName = ? AND password = ?',
      [username, password],
    ));
    return count! > 0;
  }

  Future<void> printDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'vendus_database.db');
    print(path);
  }
  
}
