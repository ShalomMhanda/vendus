import 'package:uuid/uuid.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/database/database_helper.dart';

class Product {
  String id;
  String productName;
  String unitOfMeasurement;
  double quantity;
  double cost;
  DateTime dateOfPurchase;
  String description;
  String userId; // Add this field

  Product({
    required this.productName,
    required this.unitOfMeasurement,
    required this.quantity,
    required this.cost,
    required this.dateOfPurchase,
    required this.userId, // Add this field
    this.description = "",
  }) : id = Uuid().v4();

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        productName = map['productName'],
        unitOfMeasurement = map['unitOfMeasurement'],
        quantity = map['quantity'],
        cost = map['cost'],
        dateOfPurchase = DateTime.parse(map['dateOfPurchase']),
        description = map['description'],
        userId = map['userId'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'unitOfMeasurement': unitOfMeasurement,
      'quantity': quantity,
      'cost': cost,
      'dateOfPurchase': dateOfPurchase
          .toIso8601String(), // Convert DateTime to a string format suitable for storage
      'description': description,
      'userId': userId, // Add this field
    };
  }

  Future<void> updateProductInDatabase() async {
    final db = await DatabaseHelper(authService: AuthService()).database;
    await db.update('products', toMap(),
        where: 'id = ?', whereArgs: [id]);
  }
}
