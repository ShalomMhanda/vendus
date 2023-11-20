// Example ProfitPage UI

import 'package:flutter/material.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';

class ProfitPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProfitPageState createState() => _ProfitPageState();
}

class _ProfitPageState extends State<ProfitPage> {
  final dbHelper = DatabaseHelper(authService: AuthService());
  DateTime startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profit Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Time Period:'),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Start Date:'),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        startDate = selectedDate;
                      });
                    }
                  },
                  child: Text(startDate.toLocal().toString().split(' ')[0]),
                ),
                SizedBox(width: 16),
                Text('End Date:'),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        endDate = selectedDate;
                      });
                    }
                  },
                  child: Text(endDate.toLocal().toString().split(' ')[0]),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final profit = await dbHelper.calculateProfit(startDate, endDate);
                // Display the profit using the calculated values
                // You can use a dialog, a new page, or any other method to display the results.
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Profit Calculation Result'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Total Sales: \$${profit.sellingPrice.toStringAsFixed(2)}'),
                          Text(
                              'Total Expenses: \$${profit.totalExpenses.toStringAsFixed(2)}'),
                          Text(
                              'Total Product Costs: \$${profit.totalProductCosts.toStringAsFixed(2)}'),
                          Text(
                              'Calculated Profit: \$${profit.calculatedProfit.toStringAsFixed(2)}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calculate Profit'),
            ),
          ],
        ),
      ),
    );
  }
}
