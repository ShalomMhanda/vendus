import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vendus/models/expense.dart';
import 'package:vendus/models/user.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/models/sale.dart';

class DatabaseHelper {
  static Database? _database;
  static User? _currentUser;

  final AuthService authService;

  DatabaseHelper({required this.authService});

  // DatabaseHelper(this.authService);

  Future<Database> get database async {
    print('Initialize database');
    if (_database != null) return _database!;

    // If the database does not exist, create it
    _database = await initializeDatabase();
    return _database!;
  }

  // Future<Database> initializeDatabase() async {
  //   print('Gets to initalizeDatabase() function');
  //   final String path = join(await getDatabasesPath(), 'vendus_database.db');
  //   print("before calling createDatabase");
  //   return await openDatabase(path, version: 8, onCreate: _createDatabase);
  // }

  Future<Database> initializeDatabase() async {
  print('Gets to initalizeDatabase() function');
  final String path = join(await getDatabasesPath(), 'vendus_database.db');
  print("before calling createDatabase");
  return await openDatabase(path, version: 8, onCreate: (db, version) async {
    await _createDatabase(db, version);
  }, onUpgrade: (db, oldVersion, newVersion) async {
    // Add any additional tables here
    await db.execute('''
      CREATE TABLE IF NOT EXISTS expenses(
        id TEXT PRIMARY KEY,
        userId TEXT,  -- Foreign key referencing the user who owns the expense
        expenseCategory TEXT,
        cost REAL,
        expenseDate TEXT,
        description TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS sales(
        saleId TEXT PRIMARY KEY,
        userId TEXT,  -- Foreign key referencing the user who owns the sale
        productId TEXT, -- Foreign key referencing the product being sold
        productName TEXT,
        sellingPrice REAL,
        quantitySold REAL,
        unitOfMeasurement TEXT,
        saleDate TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
        FOREIGN KEY (productId) REFERENCES products(id)
      )
    ''');
    print('Table "sales" created successfully.');
  });
}


  Future<void> _createDatabase(Database db, int version) async {
    print("Gets to the createDatabase function");
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
    print('Table "users" created successfully.');

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
    print('Table "products" created successfully.');

    // Create the 'expenses' table
    await db.execute('''
      CREATE TABLE expenses(
        id TEXT PRIMARY KEY,
        userId TEXT,  -- Foreign key referencing the user who owns the expense
        expenseCategory TEXT,
        cost REAL,
        expenseDate TEXT,
        description TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');
    print('Table "expenses" created successfully.');

    // Create the 'sales' table
    await db.execute('''
      CREATE TABLE sales(
        saleId TEXT PRIMARY KEY,
        userId TEXT,  -- Foreign key referencing the user who owns the sale
        productId TEXT, -- Foreign key referencing the product being sold
        productName TEXT,
        sellingPrice REAL,
        quantitySold REAL,
        unitOfMeasurement TEXT,
        saleDate TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
        FOREIGN KEY (productId) REFERENCES products(id)
      )
    ''');
    print('Table "sales" created successfully.');
  }

  Future<void> insertProduct(Product product) async {
    // Fetch the current user by using the loginUser method in AuthService
    final currentUserId = authService.currentUserId;
    print(currentUserId);
    final db = await database;

    try {
      // Set the userId of the product to the current user's ID
      product.userId = currentUserId;

      // Now, proceed with inserting the product into the database
      // final db = await database;
      print(product.productName);
      print('heeeerreeee');
      print(product.userId);
      await db.insert('products', product.toMap());
      print('gets hereb- saved');
    } catch (e) {
      print('Product was not saved.');
    }
  }

  Future<void> insertExpense(Expense expense) async {
    // Fetch the current user by using the loginUser method in AuthService
    final currentUserId = authService.currentUserId;
    print(currentUserId);

    try {
      // Set the userId of the product to the current user's ID
      expense.userId = currentUserId;

      // Now, proceed with inserting the product into the database
      final db = await database;
      print(expense.expenseCategory);
      print('heeeerreeee');
      print(expense.userId);
      await db.insert('expenses', expense.toMap());
      print('gets hereb- saved');
    } catch (e) {
      print('Expense was not saved.');
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
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final result = await db.query('products');
    final products = result.map((json) => Product.fromMap(json)).toList();

    // Print the product IDs retrieved from the database
    final productIds = products.map((product) => product.id).toList();
    print('Product IDs in the database: $productIds');

    return products;
  }

  Future<List<Sale>> getSales() async {
    final db = await database;
    final result = await db.query('sales');
    final sales = result.map((json) => Sale.fromMap(json)).toList();

    // Print the product IDs retrieved from the database
    final saleIds = sales.map((sale) => sale.saleId).toList();
    print('Sale IDs in the database: $saleIds');

    return sales;
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final result = await db.query('expenses');
    final expenses = result.map((json) => Expense.fromMap(json)).toList();

    // Print the product IDs retrieved from the database
    final expenseIds = expenses.map((expense) => expense.id).toList();
    print('ExpenseIDs in the database: $expenseIds');

    return expenses;
  }

  Future<void> deleteProduct(String id) async {
    try {
      final db = await database;
      print('Deleting product with ID: $id');
      await db.delete('products', where: 'id = ?', whereArgs: [id]);
      print('Product deleted successfully');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> deleteSale(String saleId) async {
    try {
      final db = await database;
      print('Deleting sale with ID: $saleId');
      await db.delete('sales', where: 'saleId = ?', whereArgs: [saleId]);
      print('Sale record deleted successfully');
    } catch (e) {
      print('Error deleting sale record: $e');
    }
  }
}
