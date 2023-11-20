import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/financial_analysis_screens.dart';
import 'package:vendus/main.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/screens/expense_list.dart';
import 'package:vendus/screens/inventory_screens.dart';
import 'package:vendus/sales_screens.dart';
import 'package:vendus/screens/expense_screens.dart';
import 'package:vendus/screens/product_list.dart';
import 'package:vendus/screens/sales_list.dart';
import 'package:vendus/screens/sales_page.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Container(
                margin: EdgeInsets.only(
                    top: 32.0, left: 16.0, right: 16.0), // Adjust margins
                child: SizedBox(
                  height: 500, // Specify the desired height
                  width: 375, // Specify the desired width
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing:
                        40.0, // Add vertical spacing between buttons
                    crossAxisSpacing:
                        40.0, // Add horizontal spacing between buttons
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InventoryManagementPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.primary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded edges
                          ),
                          padding: EdgeInsets.all(20.0), // Increase button size
                        ),
                        child: Text(
                          'Inventory Management',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.secondary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Sales Management',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalesManagementPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Expense Management',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpenseManagementPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Financial Analysis',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FinancialAnalysisPage()),
                          );
                        },
                      ),
                    ],
                  ),
                )),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class InventoryManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0), // Add 8 pixels of padding on all sides
              child: Text(
                'Inventory Management',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight:
                        FontWeight.bold), // Change the font size to 24 pixels
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0), // Adjust margins
                child: SizedBox(
                  height: 485, // Specify the desired height
                  width: 375, // Specify the desired width
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing:
                        20.0, // Add vertical spacing between buttons
                    crossAxisSpacing:
                        40.0, // Add horizontal spacing between buttons
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.primary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded edges
                          ),
                          padding: EdgeInsets.all(20.0), // Increase button size
                        ),
                        child: Text(
                          'Add Product',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductForm()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.secondary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'View Inventory',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Edit Record',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProductPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Discard Product',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscardProductPage()),
                          );
                        },
                      ),
                    ],
                  ),
                )),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class SalesManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0), // Add 8 pixels of padding on all sides
              child: Text(
                'Sales Management',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight:
                        FontWeight.bold), // Change the font size to 24 pixels
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0), // Adjust margins
                child: SizedBox(
                  height: 485, // Specify the desired height
                  width: 375, // Specify the desired width
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing:
                        20.0, // Add vertical spacing between buttons
                    crossAxisSpacing:
                        40.0, // Add horizontal spacing between buttons
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.primary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded edges
                          ),
                          padding: EdgeInsets.all(20.0), // Increase button size
                        ),
                        child: Text(
                          'Record Sale',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalesPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.secondary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'View Sales',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SalesListPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Edit Record',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditSalePage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Delete Record',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeleteSalePage()),
                          );
                        },
                      ),
                    ],
                  ),
                )),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class ExpenseManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0), // Add 8 pixels of padding on all sides
              child: Text(
                'Expense Management',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight:
                        FontWeight.bold), // Change the font size to 24 pixels
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0), // Adjust margins
                child: SizedBox(
                  height: 485, // Specify the desired height
                  width: 375, // Specify the desired width
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing:
                        20.0, // Add vertical spacing between buttons
                    crossAxisSpacing:
                        40.0, // Add horizontal spacing between buttons
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.primary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30.0), // Rounded edges
                          ),
                          padding: EdgeInsets.all(20.0), // Increase button size
                        ),
                        child: Text(
                          'Record Expense',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpensesForm()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme
                              .colorScheme.secondary, // Set the background colo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'View Expenses',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpenseListPage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Edit Record',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.primary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditExpensePage()),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Delete Record',
                          style: TextStyle(
                            color: myTheme
                                .colorScheme.onPrimary, // Set the text color
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeleteExpensePage()),
                          );
                        },
                      ),
                    ],
                  ),
                )),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class FinancialAnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0,
                  left: 16.0,
                  right: 16.0), // Add 8 pixels of padding on all sides
              child: Text(
                'Financial Analysis',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight:
                        FontWeight.bold), // Change the font size to 24 pixels
              ),
            ),
            SizedBox(
              width: 375.0,
              height: 485.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myTheme
                          .colorScheme.primary, // Set the background colo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.all(30.0),
                    ),
                    child: Text(
                      'Calculate Profit',
                      style: TextStyle(
                        color:
                            myTheme.colorScheme.onPrimary, // Set the text color
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalculateProfitPage()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myTheme
                            .colorScheme.secondary, // Set the background colo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(30.0),
                      ),
                      child: Text(
                        'Generate Trend Graphs',
                        style: TextStyle(
                          color: myTheme
                              .colorScheme.onSecondary, // Set the text color
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenerateTrendGraphsPage()),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myTheme
                          .colorScheme.primary, // Set the background colo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.all(30.0),
                    ),
                    child: Text(
                      'Reporting',
                      style: TextStyle(
                        color:
                            myTheme.colorScheme.onPrimary, // Set the text color
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GenerateReportsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0,
                  left: 16.0,
                  right: 16.0), // Add 8 pixels of padding on all sides
              child: Text(
                'More',
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight:
                        FontWeight.bold), // Change the font size to 24 pixels
              ),
            ),
            SizedBox(
              width: 375.0,
              height: 485.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myTheme
                          .colorScheme.primary, // Set the background colo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.all(30.0),
                    ),
                    child: Text(
                      'Getting Started',
                      style: TextStyle(
                        color:
                            myTheme.colorScheme.onPrimary, // Set the text color
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myTheme
                            .colorScheme.secondary, // Set the background colo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(30.0),
                      ),
                      child: Text(
                        'Support/Help',
                        style: TextStyle(
                          color: myTheme
                              .colorScheme.onSecondary, // Set the text color
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myTheme
                          .colorScheme.primary, // Set the background colo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.all(30.0),
                    ),
                    child: Text(
                      'FAQs',
                      style: TextStyle(
                        color:
                            myTheme.colorScheme.onPrimary, // Set the text color
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Text(
              'Search',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight:
                      FontWeight.bold), // Change the font size to 24 pixels
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class AccountInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var pair = appState.current;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyLogo(),
            Text(
              'Account Information',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight:
                      FontWeight.bold), // Change the font size to 24 pixels
            ),
            MyBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'images/Vendus_dark_logo.png',
          width: double.infinity,
          height: 150.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: myTheme.colorScheme.primary,
      items: [
        BottomNavigationBarItem(
          backgroundColor: myTheme.colorScheme.primary,
          icon: Icon(Icons.home, color: myTheme.colorScheme.secondary),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: myTheme.colorScheme.secondary),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon:
              Icon(Icons.account_circle, color: myTheme.colorScheme.secondary),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, color: myTheme.colorScheme.secondary),
          label: 'More',
        ),
      ],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/account');
            break;
          case 3:
            Navigator.pushNamed(context, '/more');
            break;
        }
      },
    );
  }
}
