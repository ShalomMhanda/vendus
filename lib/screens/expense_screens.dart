import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/main.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/main_screens.dart';
import 'package:vendus/models/expense.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';

class ExpensesForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExpensesFormState createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  final _formKey = GlobalKey<FormState>();
  final _costController = TextEditingController();
  final _descriptionController = TextEditingController();

  Expense _expense = Expense(
    expenseCategory: "",
    cost: 0.0,
    expenseDate: DateTime.now(),
    description: '',
    userId: '',
  );

  // // Define variables to store form data
  // String description = '';
  // double cost = 0.0;
  // DateTime? expenseDate;
  List<String> expenseCategory = [
    'Transport',
    'Food',
    'Utilities',
    'Extra Charges',
    'Others'
  ];
  String selectedExpenseCategory = 'Transport'; // Set an initial default value

  // Create an instance of the DatabaseHelper class
  final DatabaseHelper dbHelper = DatabaseHelper(authService: AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Record Expense',
          style: TextStyle(color: myTheme.colorScheme.onSecondary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60.0,
          right: 30.0,
          left: 30.0,
          bottom: 30.0,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 20)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _expense.description = value!;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              Row(
                children: [
                  Text('Expense Category: '),
                  DropdownButton<String>(
                    value: selectedExpenseCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedExpenseCategory = newValue!;
                        _expense.expenseCategory = newValue;
                      });
                    },
                    items: expenseCategory
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(
                    labelText: 'Cost',
                    hintText: '0.00',
                    labelStyle: TextStyle(fontSize: 20)),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the cost';
                  }
                  return null;
                },
                onSaved: (value) {
                  _expense.cost = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        _expense.expenseDate = pickedDate;
                      });
                    }
                  });
                },
                child: Text('Select Date'),
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      myTheme.colorScheme.primary, // Set the background colo
                  padding: EdgeInsets.all(20.0), // Increase button size
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await dbHelper.printDatabasePath();
                    try {
                      // Save expense to the database
                      final expense = Expense(
                        expenseCategory: _expense.expenseCategory,
                        cost: double.parse(_costController.text),
                        expenseDate: _expense.expenseDate,
                        description: _descriptionController.text,
                        userId: '',
                      );
                      // Save form data to database or perform other actions.
                      print(expense.expenseCategory);
                      await dbHelper.insertExpense(expense);

                      // Display success message
                      _showSnackBar('Expense recorded successfully');

                      // Navigate to the home page
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    } catch (e) {
                      _showSnackBar('Expense was not recorded successfully');
                      print('Error inserting expenset: $e');
                    }
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: myTheme.colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class DeleteExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Text(
              'Delete Expense',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight:
                      FontWeight.bold), // Change the font size to 24 pixels
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class ViewExpensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Text(
              'View Expenses',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight:
                      FontWeight.bold), // Change the font size to 24 pixels
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class EditExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Text(
              'Edit Expense',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight:
                      FontWeight.bold), // Change the font size to 24 pixels
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}
