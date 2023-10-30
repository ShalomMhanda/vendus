import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/main.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/main_screens.dart';
import 'package:vendus/models.dart';

class ProductForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  // Define variablesore form data
  Product _product = Product(
    productName: "",
    unitOfMeasurement: "",
    quantity: 0.0,
    cost: 0.0,
    dateOfPurchase: DateTime.now(),
  );

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
                  _product.productName = value!;
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
                        _product.unitOfMeasurement = newValue!;
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
                decoration:
                    InputDecoration(labelText: 'Quantity', hintText: '0'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _product.quantity = double.parse(value!);
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Cost', hintText: '0.00'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _product.cost = double.parse(value!);
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
                        _product.dateOfPurchase = pickedDate;
                      });
                    }
                  });
                },
                child: Text("Select Date"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _product.description = value!;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        _formKey.currentState!.save();
                        // Store form data in Product object.
                        Product product = Product(
                          productName: _product.productName,
                          unitOfMeasurement: _product.unitOfMeasurement,
                          quantity: _product.quantity,
                          cost: _product.cost,
                          dateOfPurchase: _product.dateOfPurchase,
                          description: _product.description,
                        );
                        print(product);
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text(
                      'Save Product',
                      style: TextStyle(
                          color: myTheme.colorScheme.onPrimary, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: myTheme.colorScheme.primary),
                  )),
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
