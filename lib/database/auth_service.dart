import 'package:vendus/models/user.dart';
import 'package:vendus/database/database_helper.dart';

class AuthService {
  static String _currentUserId = '';
  static User? _currentUser;

  Future<bool> loginUser(String username, String password) async {
    final databaseHelper = DatabaseHelper(authService: AuthService());

    final user =
        await databaseHelper.getUserByUsernameAndPassword(username, password);

    if (user != null) {
      // Set the current user ID to the fetched user's ID
      _currentUserId = user.id;
      return true;
    }

    return false;
  }

  String get currentUserId => _currentUserId;

  // Method to simulate user logout
  Future<void> logoutUser() async {
    _currentUser = null;
  }

  // Get the current user
  User? get currentUser => _currentUser;
}
