import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/main.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/main_screens.dart';

class ExpensesForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExpensesFormState createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to store form data
  String description = '';
  double cost = 0.0;
  DateTime? expenseDate;
  List<String> expenseCategory = [
    'Transport',
    'Food',
    'Utilities',
    'Extra Charges',
    'Others'
  ];
  String selectedExpenseCategory = 'Transport'; // Set an initial default value

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
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value!;
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
                decoration: InputDecoration(labelText: 'Cost'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  cost = double.parse(value!);
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
                        expenseDate = pickedDate;
                      });
                    }
                  });
                },
                child: Text(expenseDate != null
                    ? 'Selected Date: ${expenseDate!.toLocal()}'
                    : 'Select Expense Date'),
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      myTheme.colorScheme.primary, // Set the background colo
                  padding: EdgeInsets.all(20.0), // Increase button size
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save form data to database or perform other actions.
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
