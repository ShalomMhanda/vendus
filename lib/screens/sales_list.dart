import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vendus/models/sale.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';

class SalesListPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SalesListPageState createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales List'),
      ),
      body: FutureBuilder<List<Sale>>(
        future: dbHelper.getSales(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final sales = snapshot.data!;
            return ListView.builder(
              itemCount: sales.length,
              itemBuilder: (context, index) {
                final sale = sales[index];
                return ListTile(
                  title: Text(sale.productName),
                  subtitle: Text(
                      '${sale.quantitySold} ${sale.unitOfMeasurement} ${sale.sellingPrice}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      print('Deleting sale: ${sale.saleId}');
                      print(await getDatabasesPath());
                      await dbHelper.deleteSale(sale.saleId);
                      print('Deleted succesffully');
                      setState(() {});
                    },
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
