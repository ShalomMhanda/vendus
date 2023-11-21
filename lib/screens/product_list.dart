import 'package:flutter/material.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/screens/edit_product.dart';
import 'package:vendus/app_theme.dart';

class ProductListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());
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

  Future<void> _confirmDelete(Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${product.productName}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await dbHelper.deleteProduct(product.id);
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Product List',
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
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: dbHelper.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      if (_searchQuery.isNotEmpty &&
                          !product.productName
                              .toLowerCase()
                              .contains(_searchQuery)) {
                        return Container(); // Skip products that don't match the search query
                      }
                      return ListTile(
                        title: Text(product.productName),
                        subtitle: Text(
                            '${product.quantity} ${product.unitOfMeasurement}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProductPage(product: product),
                                  ),
                                ).then((value) {
                                  // Reload the product list after editing
                                  setState(() {});
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                // print('Deleting product: ${product.id}');
                                // print(await getDatabasesPath());
                                // await dbHelper.deleteProduct(product.id);
                                // print('Deleted successfully');
                                // setState(() {});
                                _confirmDelete(product);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
