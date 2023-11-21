import 'package:flutter/material.dart';
import 'package:vendus/models/sale.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/app_theme.dart';

class EditSalePage extends StatefulWidget {
  final Sale sale;

  EditSalePage({required this.sale});

  @override
  // ignore: library_private_types_in_public_api
  _EditSalePageState createState() => _EditSalePageState();
}

class _EditSalePageState extends State<EditSalePage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantitySoldController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper(authService: AuthService());

  Sale _sale = Sale(
    productName: "",
    unitOfMeasurement: "",
    quantitySold: 0.0,
    sellingPrice: 0.0,
    saleDate: DateTime.now(),
    userId: '',
    productId: '',
  );

  @override
  void initState() {
    super.initState();

    // Set initial values for form fields based on the product data
    _productNameController.text = widget.sale.productName;
    _quantitySoldController.text = widget.sale.quantitySold.toString();
    _sellingPriceController.text = widget.sale.sellingPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Edit Sale',
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
                  _sale.productName = value!;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              TextFormField(
                controller: _quantitySoldController,
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
                  _sale.quantitySold = double.parse(value!);
                },
              ),
              TextFormField(
                controller: _sellingPriceController,
                decoration: InputDecoration(
                    labelText: 'Selling Price',
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
                  _sale.sellingPrice = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Update product logic
                    widget.sale.productName = _productNameController.text;
                    widget.sale.quantitySold =
                        double.parse(_quantitySoldController.text);
                    widget.sale.sellingPrice =
                        double.parse(_sellingPriceController.text);
                    widget.sale.unitOfMeasurement = _sale.unitOfMeasurement;
                    widget.sale.saleDate = _sale.saleDate;

                    await dbHelper.updateSaleInDatabase(widget.sale);

                    _showSnackBar('Sale updated successfully');

                    // Navigate back to the product list page
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: myTheme.colorScheme.primary),
                child: Text(
                  'Update Sale',
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
