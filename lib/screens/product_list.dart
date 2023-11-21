import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendus/models/product.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/models/user.dart';
import 'package:vendus/screens/edit_product.dart';
import 'package:vendus/app_theme.dart';

class ProductListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());

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
      body: FutureBuilder<List<Product>>(
        future: dbHelper.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle:
                      Text('${product.quantity} ${product.unitOfMeasurement}'),
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
                          print('Deleting product: ${product.id}');
                          print(await getDatabasesPath());
                          await dbHelper.deleteProduct(product.id);
                          print('Deleted successfully');
                          setState(() {});
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
    );
  }
}
