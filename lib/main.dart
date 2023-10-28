import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/main_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'vendus',
        theme: myTheme,
        home: MyHomePage(),
        routes: {
          '/home': (context) => MyHomePage(),
          '/search': (context) => SearchPage(),
          '/account': (context) => AccountInformationPage(),
          '/more': (context) => MorePage(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}
