import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/main.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/main_screens.dart';

class ProductForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to store form data
  String productName = '';
  double quantity = 0.0;
  double cost = 0.0;
  DateTime? purchaseDate;
  String description = '';
  List<String> measurementUnits = [
    'kg',
    'gallons',
    'pockets',
    'packets',
    'count'
  ];
  String selectedMeasurementUnit = 'kg'; // Set an initial default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Add Product',
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
                decoration: InputDecoration(labelText: 'Product Name'),
                onSaved: (value) {
                  productName = value!;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              Row(
                children: [
                  Text('Unit of Measurement: '),
                  DropdownButton<String>(
                    value: selectedMeasurementUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMeasurementUnit = newValue!;
                      });
                    },
                    items: measurementUnits
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
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  quantity = double.parse(value!);
                },
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
                        purchaseDate = pickedDate;
                      });
                    }
                  });
                },
                child: Text(purchaseDate != null
                    ? 'Selected Date: ${purchaseDate!.toLocal()}'
                    : 'Select Purchase Date'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value!;
                },
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
                  'Add Product',
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

class DiscardProductPage extends StatelessWidget {
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
              'Discard Product',
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

class ViewInventoryPage extends StatelessWidget {
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
              'View Inventory',
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

class EditProductPage extends StatelessWidget {
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
              'Edit Product',
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
