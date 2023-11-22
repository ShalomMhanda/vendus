import 'package:flutter/material.dart';
import 'package:vendus/database/database_helper.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/app_theme.dart';

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
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Profit Calculator',
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
            Text(
              'Select Time Period:',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Start Date:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 16),
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
                      style: TextButton.styleFrom(
                        backgroundColor: myTheme.colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 50),
                      ),
                      child: Text(
                        startDate.toLocal().toString().split(' ')[0],
                        style:
                            TextStyle(color: myTheme.colorScheme.onSecondary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // SizedBox(width: 16),
                Row(
                  children: [
                    Text(
                      'End Date:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 26),
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
                      style: TextButton.styleFrom(
                        backgroundColor: myTheme.colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 50),
                      ),
                      child: Text(
                        endDate.toLocal().toString().split(' ')[0],
                        style:
                            TextStyle(color: myTheme.colorScheme.onSecondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
              child: ElevatedButton(
                onPressed: () async {
                  final profit =
                      await dbHelper.calculateProfit(startDate, endDate);
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
                              'Total Sales: \$${profit.sellingPrice.toStringAsFixed(2)}',
                            ),
                            Text(
                              'Total Expenses: \$${profit.totalExpenses.toStringAsFixed(2)}',
                            ),
                            Text(
                              'Total Product Costs: \$${profit.totalProductCosts.toStringAsFixed(2)}',
                            ),
                            Text(
                              'Calculated Profit: \$${profit.calculatedProfit.toStringAsFixed(2)}',
                            ),
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
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 40),
                    backgroundColor: myTheme.colorScheme.primary),
                child: Text(
                  'Calculate Profit',
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
}
