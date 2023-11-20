import 'package:uuid/uuid.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/database/database_helper.dart';

class Sale {
  String saleId;
  String productId; // Reference to the product that was sold
  String productName;
  double sellingPrice;
  String unitOfMeasurement;
  double quantitySold;
  DateTime saleDate;
  String userId; // Add this field if needed

  Sale({
    required this.productId,
    required this.productName,
    required this.sellingPrice,
    required this.unitOfMeasurement,
    required this.quantitySold,
    required this.saleDate,
    required this.userId, // Add this field if needed
  }) : saleId = Uuid().v4();

  Sale.fromMap(Map<String, dynamic> map)
      : saleId = map['saleId'],
        productId = map['productId'],
        productName = map['productName'],
        sellingPrice = map['sellingPrice'],
        unitOfMeasurement = map['unitOfMeasurement'],
        quantitySold = map['quantitySold'],
        saleDate = DateTime.parse(map['saleDate']),
        userId = map['userId'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'saleId': saleId,
      'productId': productId,
      'productName': productName,
      'sellingPrice': sellingPrice,
      'unitOfMeasurement': unitOfMeasurement,
      'quantitySold': quantitySold,
      'saleDate': saleDate.toIso8601String(),
      'userId': userId, // Add this field if needed
    };
  }

  Future<void> addSaleToDatabase() async {
    final db = await DatabaseHelper(authService: AuthService()).database;
    await db.insert('sales', toMap());
  }
}

