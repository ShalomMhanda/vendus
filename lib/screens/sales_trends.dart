import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/models/sale.dart'; // Import your Sale model
import 'package:vendus/database/database_helper.dart'; // Import your DatabaseHelper

class SalesTrendPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SalesTrendPageState createState() => _SalesTrendPageState();
}

class _SalesTrendPageState extends State<SalesTrendPage> {
  List<Sale> salesData = [];

  @override
  void initState() {
    super.initState();
    _fetchSalesData();
  }

  Future<void> _fetchSalesData() async {
    final dbHelper = DatabaseHelper(authService: AuthService());
    final sales = await dbHelper.getSales();

    setState(() {
      salesData = sales;
    });
  }

  Map<int, double> calculateDailyTotalSales(List<Sale> sales) {
    Map<int, double> dailyTotalSales = {};

    for (var sale in sales) {
      int dayOfWeek = sale.saleDate.weekday;

      // Assuming your Sale model has a field named 'sellingPrice'
      dailyTotalSales[dayOfWeek] =
          (dailyTotalSales[dayOfWeek] ?? 0) + sale.sellingPrice;
    }

    return dailyTotalSales;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, double> dailyTotalSales = calculateDailyTotalSales(salesData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Trend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: dailyTotalSales.isNotEmpty
            ? SalesTrendChart(dailyTotalSales: dailyTotalSales)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class SalesTrendChart extends StatelessWidget {
  final Map<int, double> dailyTotalSales;

  SalesTrendChart({required this.dailyTotalSales});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              // Map days of the week to their corresponding values
              final Map<int, String> daysOfWeek = {
                1: 'Mon',
                2: 'Tue',
                3: 'Wed',
                4: 'Thu',
                5: 'Fri',
                6: 'Sat',
                7: 'Sun',
              };
              return daysOfWeek[value.toInt()] ?? '';
            },
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        minX: 1,
        maxX: 7,
        minY: 0,
        maxY: dailyTotalSales.values.reduce((a, b) => a > b ? a : b) * 1.2,
        lineBarsData: [
          LineChartBarData(
            spots: _generateSpots(),
            isCurved: true,
            belowBarData: BarAreaData(show: false),
            aboveBarData: BarAreaData(show: false),
            dotData: FlDotData(show: true),
            show: true,
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    return List.generate(7, (index) {
      return FlSpot((index + 1).toDouble(), dailyTotalSales[index + 1] ?? 0);
    });
  }
}
