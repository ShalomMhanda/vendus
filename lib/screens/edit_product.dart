import 'package:flutter/material.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/app_theme.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _costController = TextEditingController();
  final _descriptionController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper(authService: AuthService());

  Product _product = Product(
    productName: "",
    unitOfMeasurement: "",
    quantity: 0.0,
    cost: 0.0,
    dateOfPurchase: DateTime.now(),
    userId: '',
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
  void initState() {
    super.initState();

    // Set initial values for form fields based on the product data
    _productNameController.text = widget.product.productName;
    _quantityController.text = widget.product.quantity.toString();
    _costController.text = widget.product.cost.toString();
    _descriptionController.text = widget.product.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Edit Product',
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
                controller: _productNameController,
                decoration: InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(fontSize: 22)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _product.productName = value!;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              Row(
                children: [
                  Text('Unit of Measurement: ', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: selectedMeasurementUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMeasurementUnit = newValue!;
                        _product.unitOfMeasurement = newValue;
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
                controller: _quantityController,
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    hintText: '0',
                    labelStyle: TextStyle(fontSize: 22)),
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
                  _product.description = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Update product logic
                    widget.product.productName = _productNameController.text;
                    widget.product.quantity =
                        double.parse(_quantityController.text);
                    widget.product.cost = double.parse(_costController.text);
                    widget.product.unitOfMeasurement =
                        _product.unitOfMeasurement;
                    widget.product.dateOfPurchase = _product.dateOfPurchase;
                    widget.product.description = _descriptionController.text;

                    await dbHelper.updateProductInDatabase(widget.product);

                    _showSnackBar('Product updated successfully');

                    // Navigate back to the product list page
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: myTheme.colorScheme.primary),
                child: Text(
                  'Update Product',
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
