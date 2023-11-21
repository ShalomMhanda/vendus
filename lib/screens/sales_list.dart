import 'package:flutter/material.dart';
import 'package:vendus/models/sale.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/screens/edit_sale.dart';

class SalesListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());
  List<Sale> _sales = []; // List of products to display
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch products from the database and update _products
    _fetchSales();
  }

  Future<void> _fetchSales() async {
    // Fetch products from the database using DatabaseHelper
    _sales = await DatabaseHelper(authService: AuthService()).getSales();
    setState(() {}); // Update the UI
  }

  Future<void> _confirmDelete(Sale sale) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${sale.productName}?'),
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
                await dbHelper.deleteSale(sale.saleId);
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
          'Sales List',
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
            child: FutureBuilder<List<Sale>>(
              future: dbHelper.getSales(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final sales = snapshot.data!;
                  return ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      final sale = _sales[index];
                      if (_searchQuery.isNotEmpty &&
                          !sale.productName
                              .toLowerCase()
                              .contains(_searchQuery)) {
                        return Container(); // Skip products that don't match the search query
                      }
                      return ListTile(
                        title: Text(sale.productName),
                        subtitle: Text(
                            '${sale.quantitySold} ${sale.unitOfMeasurement} ${sale.sellingPrice}'),
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
                                        EditSalePage(sale: sale),
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
                                _confirmDelete(sale);
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
