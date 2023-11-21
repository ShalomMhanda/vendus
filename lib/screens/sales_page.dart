import 'package:flutter/material.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/screens/sales_form.dart';
import 'package:vendus/app_theme.dart';

class SalesPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<Product> _products = []; // List of products to display
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch products from the database and update _products
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // Fetch products from the database using DatabaseHelper
    _products = await DatabaseHelper(authService: AuthService()).getProducts();
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Products List',
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
                hintText: 'Search products...',
              ),
            ),
          ),
          // Product list
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                if (_searchQuery.isNotEmpty &&
                    !product.productName.toLowerCase().contains(_searchQuery)) {
                  return Container(); // Skip products that don't match the search query
                }
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text('Quantity: ${product.quantity}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Navigate to the sale form with the selected product
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaleFormPage(product: product),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: myTheme.colorScheme.primary),
                    child: Text(
                      'Sell',
                      style: TextStyle(color: myTheme.colorScheme.onPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
