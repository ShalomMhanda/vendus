import 'package:flutter/material.dart';
import 'package:vendus/models/expense.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/screens/edit_expense.dart';

class ExpenseListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());
  List<Expense> _expenses = []; // List of expenses to display
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch products from the database and update _products
    _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    // Fetch products from the database using DatabaseHelper
    _expenses = await DatabaseHelper(authService: AuthService()).getExpenses();
    setState(() {}); // Update the UI
  }

  Future<void> _confirmDelete(Expense expense) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to delete ${expense.expenseCategory}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await dbHelper.deleteExpense(expense.id);
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Expenses List',
          style: TextStyle(color: myTheme.colorScheme.onSecondary),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search expenses...',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Expense>>(
              future: dbHelper.getExpenses(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final expenses = snapshot.data!;
                  return ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      if (_searchQuery.isNotEmpty &&
                          !expense.expenseCategory
                              .toLowerCase()
                              .contains(_searchQuery)) {
                        return Container(); // Skip products that don't match the search query
                      }
                      return ListTile(
                        title: Text(expense.expenseCategory),
                        subtitle:
                            Text('${expense.cost} ${expense.expenseDate}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditExpensePage(expense: expense),
                                  ),
                                ).then((value) {
                                  // Reload the product list after editing
                                  setState(() {});
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                _confirmDelete(expense);
                              },
                            ),
                          ],
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
          ),
        ],
      ),
    );
  }
}
