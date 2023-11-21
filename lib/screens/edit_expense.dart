import 'package:flutter/material.dart';
import 'package:vendus/models/expense.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/app_theme.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;

  EditExpensePage({required this.expense});

  @override
  // ignore: library_private_types_in_public_api
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _costController = TextEditingController();
  final _descriptionController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper(authService: AuthService());

  Expense _expense = Expense(
    expenseCategory: "",
    cost: 0.0,
    expenseDate: DateTime.now(),
    description: "",
    userId: '',
  );

  List<String> expenseCategory = [
    'Transport',
    'Food',
    'Utilities',
    'Extra Charges',
    'Others'
  ];
  String selectedExpenseCategory = 'Transport'; // Set an initial default value

  @override
  void initState() {
    super.initState();

    // Set initial values for form fields based on the product data
    _costController.text = widget.expense.cost.toString();
    _descriptionController.text = widget.expense.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Edit Expense Record',
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
                    labelStyle: TextStyle(fontSize: 22)),
                maxLines: 3,
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
              SizedBox(height: 16.0), // Add more vertical spacing
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(
                    labelText: 'Cost',
                    hintText: '0.00',
                    labelStyle: TextStyle(fontSize: 22)),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
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
                child: Text("Select Date"),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Update expense logic
                    widget.expense.description = _descriptionController.text;
                    widget.expense.expenseCategory = _expense.expenseCategory;
                    widget.expense.cost = double.parse(_costController.text);
                    widget.expense.expenseDate = _expense.expenseDate;

                    await dbHelper.updateExpenseInDatabase(widget.expense);

                    _showSnackBar('Expense updated successfully');

                    // Navigate back to the product list page
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: myTheme.colorScheme.primary),
                child: Text(
                  'Update Expense',
                  style: TextStyle(
                      color: myTheme.colorScheme.onPrimary, fontSize: 20),
                  textAlign: TextAlign.center,
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
