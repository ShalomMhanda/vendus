import 'package:uuid/uuid.dart';

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

  // factory Product.fromMap(Map<String, dynamic> map) {
  //   return Product(
  //     id =  map['id'],
  //     productName =  map['productName'],
  //     unitOfMeasurement: map['unitOfMeasurement'],
  //     quantity: map['quantity'],
  //     cost: map['cost'],
  //     dateOfPurchase: DateTime.parse(map['dateOfPurchase']),
  //     description: map['description'],
  //     userId: map['userId'] ?? '',
  //   );
  // }

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
}
