// Example SaleFormPage UI

import 'package:flutter/material.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/models/sale.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.product.productName}'),
            SizedBox(height: 16),
            TextField(
              controller: _sellingPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Selling Price'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity Sold'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Validate and record the sale
                final sellingPrice = double.parse(_sellingPriceController.text);
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
              child: Text('Record Sale'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recordSale(
      Product selectedProduct, double sellingPrice, double quantitySold) async {
    // Deduct the sold quantity from the available quantity in the product table
    selectedProduct.quantity -= quantitySold;
    await selectedProduct.updateProductInDatabase();

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

    await sale.addSaleToDatabase();
  }
}
