import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';

  // Dummy credentials for testing
  static const String dummyEmail = 'test@example.com';
  static const String dummyPassword = 'password123';

  // Check if user is already logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get saved user data
  Future<Map<String, String>> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(_userEmailKey) ?? '',
      'name': prefs.getString(_userNameKey) ?? '',
    };
  }

  // Simulated login with dummy credentials
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == dummyEmail && password == dummyPassword) {
      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userEmailKey, email);
      await prefs.setString(_userNameKey, 'Test User');

      return {
        'success': true,
        'user': {
          'email': email,
          'name': 'Test User',
        },
      };
    }

    return {
      'success': false,
      'error': 'Invalid email or password',
    };
  }

  // Dummy credentials info for display
  static String get dummyCredentials => 'Email: $dummyEmail\nPassword: $dummyPassword';

  Future<void> logout() async {
    // Clear login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userNameKey);

    // Simulate logout
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
