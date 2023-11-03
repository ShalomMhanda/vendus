import 'package:flutter/material.dart';
import 'package:vendus/app_theme.dart';
import 'package:vendus/models.dart';

class RegistrationForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  // Create a User object to store the registration data
  User _user = User(userName: '', password: '', email: '', phoneNumber: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, save the data to the User object
                    _user.userName = _userNameController.text;
                    _user.password = _passwordController.text;
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
            ),
          ],
        ),
      ),
    );
  }
}
