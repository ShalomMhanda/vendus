import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vendus/models/user.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/database/auth_service.dart';

class DatabaseHelper {
  static Database? _database;
  static User? _currentUser;

  final AuthService authService;

  DatabaseHelper({required this.authService});

  // DatabaseHelper(this.authService);

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

  Future<void> insertProduct(Product product) async {
    // Fetch the current user by using the loginUser method in AuthService
    final currentUserId = authService.currentUserId;

    try {
      // Set the userId of the product to the current user's ID
      product.userId = currentUserId;

      // Now, proceed with inserting the product into the database
      final db = await database;
      print(product.productName);
      print('heeeerreeee');
      await db.insert('products', product.toMap());
      print('gets hereb- saved');
    } catch (e) {
      print('Product was not saved.');
    }
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<bool> isUsernamePasswordCombinationExists(
      String username, String password) async {
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

  Future<bool> loginUser(String username, String password) async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT * FROM users WHERE username = ? AND password = ?',
        [username, password]);
    // if (result.isNotEmpty) {
    //   _currentUser = getUserByUsernameAndPassword(username, password) as User?;
    // }
    return result.isNotEmpty;
  }

  Future<User?> getUserByUsernameAndPassword(
      String username, String password) async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT * FROM users WHERE userName = ? AND password = ?',
        [username, password]);

    if (result.isNotEmpty) {
      // Assuming there's only one user with the given username and password
      return User.fromMap(result.first);
    }

    return null;

    // if (result.isNotEmpty) {
    //   // User login successful, set the current user in AuthService
    //   final Map<String, dynamic> userMap = result.first;
    //   final User currentUser = User.fromMap(userMap);
    //   authService.setCurrentUser(currentUser);
    //   return true;
    // }

    // return false;
  }
}
