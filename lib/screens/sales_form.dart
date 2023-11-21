import 'package:flutter/material.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/models/sale.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/database/database_helper.dart';

class SaleFormPage extends StatefulWidget {
  final Product product;

  SaleFormPage({required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _SaleFormPageState createState() => _SaleFormPageState();
}

class _SaleFormPageState extends State<SaleFormPage> {
  TextEditingController _sellingPriceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper(authService: AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Record Sales',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.product.productName}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            TextField(
              controller: _sellingPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Selling Price',
                  labelStyle: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Quantity Sold',
                  labelStyle: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate and record the sale
                  final sellingPrice =
                      double.parse(_sellingPriceController.text);
                  final quantitySold = double.parse(_quantityController.text);

                  if (sellingPrice <= 0 || quantitySold <= 0) {
                    // Handle invalid input
                    return;
                  }

                  // Record the sale in the database
                  await recordSale(widget.product, sellingPrice, quantitySold);

                  // Navigate back to the sales page
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: myTheme.colorScheme.primary),
                child: Text(
                  'Record Sale',
                  style: TextStyle(
                      color: myTheme.colorScheme.onPrimary, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recordSale(
      Product selectedProduct, double sellingPrice, double quantitySold) async {
    final db = await DatabaseHelper(authService: AuthService()).database;

    // Fetch the product from the database
    final product = await db
        .query('products', where: 'id = ?', whereArgs: [selectedProduct.id]);

    if (product.isNotEmpty) {
      final availableQuantity = product[0]['quantity'] as double;

      // Check if there is enough quantity available for sale
      if (availableQuantity >= quantitySold) {
        // Deduct the sold quantity from the available quantity in the product table
        final newQuantity = availableQuantity - quantitySold;
        await db.update('products', {'quantity': newQuantity},
            where: 'id = ?', whereArgs: [selectedProduct.id]);

        // Record the sale
        final sale = Sale(
          productId: selectedProduct.id,
          productName: selectedProduct.productName,
          sellingPrice: sellingPrice,
          unitOfMeasurement: selectedProduct.unitOfMeasurement,
          quantitySold: quantitySold,
          saleDate: DateTime.now(),
          userId: selectedProduct.userId, // Use the product owner's ID
        );

        // Add the sale to the database
        await sale.addSaleToDatabase();

        // Print success message or perform other actions
        _showSnackBar('Sale recorded successfully');
        print('Sale recorded successfully');
      } else {
        // Print an error message indicating insufficient quantity
        _showSnackBar('Error: Insufficient quantity available for sale');
        print('Error: Insufficient quantity available for sale');
      }
    } else {
      // Print an error message indicating that the product was not found
      _showSnackBar('Error: Product not found in the database');
      print('Error: Product not found in the database');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
