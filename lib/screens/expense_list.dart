import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendus/models/expense.dart';
import 'package:vendus/models/expense.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/models/user.dart';
import 'package:vendus/app_theme.dart';

class ExpenseListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Expense List',
          style: TextStyle(color: myTheme.colorScheme.onSecondary),
        ),
      ),
      body: FutureBuilder<List<Expense>>(
        future: dbHelper.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final expenses = snapshot.data!;
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  title: Text(expense.expenseCategory),
                  subtitle:
                      Text('${expense.cost} ${expense.expenseDate}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      print('Deleting product: ${expense.id}');
                      print(await getDatabasesPath());
                      await dbHelper.deleteProduct(expense.id);
                      print('Deleted succesffully');
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
