import 'package:uuid/uuid.dart';

class User {
  String id;
  String userName;
  String password; // Hashed and salted password
  final String email;
  final String phoneNumber; // Use a string for phone numbers
  final String role;

  User({
    required this.userName,
    required this.password,
    this.email = "",
    this.phoneNumber = "",
    this.role = "user",
  }) : id = Uuid().v4();

  // Define the toMap method to convert User to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
