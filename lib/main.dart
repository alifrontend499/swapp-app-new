import 'package:flutter/material.dart';

// routing
import 'theme/routing/router.dart' as router;
import 'package:app/theme/routing/routing_constants.dart';

// consts
import 'package:app/theme/commonConst/textConsts.dart';

// shared preferences
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // shared preferences
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  bool isLoggedIn = sharedPrefs.getBool(SHARED_PREF_KEY_IS_USER_LOGGED_IN) ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Swaap",
      onGenerateRoute: router.generateRoutes,
      initialRoute: isLoggedIn ? contentMainScreenRoute : initialScreenRoute,
    );
  }
}
