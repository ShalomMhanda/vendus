import 'package:flutter/material.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/models/user.dart';
import 'package:vendus/database/database_helper.dart';

import 'login_screen.dart';

class RegistrationForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  // Create a User object to store the registration data
  User _user = User(userName: '', password: '', email: '', phoneNumber: '');

  // Create an instance of the DatabaseHelper class
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: myTheme.colorScheme.secondary,
        title: Text(
          'Account Registration',
          style: TextStyle(color: myTheme.colorScheme.onSecondary),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60.0,
          right: 30.0,
          left: 30.0,
          bottom: 30.0,
        ),
        child: Form(
          key: _formKey, // Associate the _formKey with the Form widget
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:
                      TextStyle(fontSize: 20), // Change the font size as needed
                ),
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              TextFormField(
                controller:
                    _passwordController, // Associates with the Password field
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(fontSize: 20), // Change the font size as needed
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing
              TextFormField(
                controller:
                    _retypePasswordController, // Associates with the Retype Password field
                decoration: InputDecoration(
                  labelText: 'Retype Password',
                  labelStyle:
                      TextStyle(fontSize: 20), // Change the font size as needed
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please retype the password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0), // Add more vertical spacing

              // Registration button
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.secondary),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: myTheme.colorScheme.onSecondary,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text('or'),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          // if (_formKey.currentState!.validate()) {
                          // If the form is valid, save the data to the User object
                          _user.userName = _userNameController.text;
                          _user.password = _passwordController.text;

                          // Print statements for debugging
                          print('User ID: ${_user.id}');
                          print('_user.userName: ${_user.userName}');
                          print('_user.password: ${_user.password}');

                          await dbHelper.printDatabasePath();

                          // Check if the username and password combination already exists
                          if (await dbHelper
                              .isUsernamePasswordCombinationExists(
                                  _user.userName, _user.password)) {
                            // Display error message
                            _showSnackBar(
                                'Username and password combination already exists');
                          } else {
                            try {
                              // Save user to the database
                              await dbHelper.insertUser(_user);
                              print('Gooooooo');
                              // Display success message
                              _showSnackBar('Account created successfully');
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            } catch (e) {
                              print('Error inserting user: $e');
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.colorScheme.primary),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: myTheme.colorScheme.onPrimary, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
