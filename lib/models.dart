import 'package:uuid/uuid.dart';

class User {
  String id;
  String userName;
  String password; // Hashed and salted password
  final String email;
  final String phoneNumber; // Use a string for phone numbers
  final String role;

  User({
    required this.userName,
    required this.password,
    this.email = "",
    this.phoneNumber = "",
    this.role = "user",
  }) : id = Uuid().v4();
}

class Product {
  String id;
  String productName;
  String unitOfMeasurement;
  double quantity;
  double cost;
  DateTime dateOfPurchase;
  String description;

  Product({
    required this.productName,
    required this.unitOfMeasurement,
    required this.quantity,
    required this.cost,
    required this.dateOfPurchase,
    this.description = "",
  }) : id = Uuid().v4();
}

// expense.dart
class Expense {
  String id;
  final String expenseCategory;
  final double cost;
  final DateTime expenseDate;
  final String description;

  Expense({
    required this.expenseCategory,
    required this.cost,
    required this.expenseDate,
    this.description = "",
  }) : id = Uuid().v4();
}

// purchase.dart
// class Purchase {
//   final String id;
//   final String productId;
//   final double quantity;
//   final DateTime date;
//   // Other properties and methods
// }

// // sale.dart
// class Sale {
//   final String id;
//   final String productId;
//   final double quantity;
//   final DateTime date;
//   // Other properties and methods
// }
