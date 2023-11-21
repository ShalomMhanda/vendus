import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vendus/database/auth_service.dart';
import 'package:vendus/models/sale.dart'; // Import your Sale model
import 'package:vendus/database/database_helper.dart'; // Import your DatabaseHelper

class SalesTrendChart extends StatelessWidget {
  final List<Sale> salesData;

  SalesTrendChart({required this.salesData});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(showTitles: true),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: salesData.length.toDouble() - 1,
        minY: 0,
        maxY: _calculateMaxY(),
        lineBarsData: [
          LineChartBarData(
            spots: _generateSpots(),
            isCurved: true,
            // colors: Colors.black,
            // color: Colors.blue,
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
    return List.generate(salesData.length, (index) {
      return FlSpot(index.toDouble(), salesData[index].sellingPrice);
    });
  }

  double _calculateMaxY() {
    return salesData.fold<double>(
            0,
            (prev, sale) =>
                prev > sale.sellingPrice ? prev : sale.sellingPrice) *
        1.2;
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Trend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: salesData.isNotEmpty
            ? SalesTrendChart(salesData: salesData)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
