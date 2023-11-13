// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Form Demo',
//       home: LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future<Database> _database;

//   @override
//   void initState() {
//     super.initState();
//     _database = _initializeDatabase();
//   }

//   Future<Database> _initializeDatabase() async {
//     final String path = join(await getDatabasesPath(), 'users.db');
//     return await openDatabase(path, version: 1, onCreate: (db, version) {
//       db.execute('''
//         CREATE TABLE users(
//           id INTEGER PRIMARY KEY,
//           username TEXT,
//           password TEXT
//         )
//       ''');
//     });
//   }

//   Future<bool> _loginUser(String username, String password) async {
//     final db = await _database;
//     final result = await db.rawQuery(
//         'SELECT * FROM users WHERE username = ? AND password = ?',
//         [username, password]);
//     return result.isNotEmpty;
//   }

//   void _handleLogin() async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;
//     final success = await _loginUser(username, password);
//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid username or password')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState.validate()) {
//                     _handleLogin();
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: Text('Welcome!'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendus/main.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/main_screens.dart';

class LoginPage extends StatelessWidget {
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
              'Login',
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