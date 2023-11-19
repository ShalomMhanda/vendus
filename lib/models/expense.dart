import 'package:uuid/uuid.dart';

class Expense {
  String id;
  String expenseCategory;
  double cost;
  DateTime expenseDate;
  String description;
  String userId; // Add this field

  Expense({
    required this.expenseCategory,
    required this.cost,
    required this.expenseDate,
    this.description = "",
    required this.userId, // Add this field
  }) : id = Uuid().v4();

  Expense.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        expenseCategory = map['expenseCategory'],
        cost = map['cost'],
        expenseDate = DateTime.parse(map['expenseDate']),
        description = map['description'],
        userId = map['userId'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expenseCategory': expenseCategory,
      'cost': cost,
      'expenseDate': expenseDate
          .toIso8601String(), // Convert DateTime to a string format suitable for storage
      'description': description,
      'userId': userId, // Add this field
    };
  }
}
