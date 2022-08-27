
// shared preferences
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const _ketUserEmail = 'userEmail';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  // get & set user email
  static Future setUserEmail(String userEmail) async => await _preferences?.setString(userEmail, userEmail);
  static String getUserEmail() => _preferences?.getString(_ketUserEmail) ?? '';

  // check if user is logged in
  static bool isUserLoggedIn() => _preferences?.getBool(_ketUserEmail) ?? false;

  // get & set user name
  static Future setUserName(String userName) async => await _preferences?.setString(userName, userName);
  static String? getUserName() => _preferences?.getString(_ketUserEmail);
}