import 'package:uuid/uuid.dart';


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