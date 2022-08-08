import 'package:flutter/material.dart';

// routing
import 'theme/routing/router.dart' as router;
import 'package:app/theme/routing/routing_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Swapp App',
      onGenerateRoute: router.generateRoutes,
      initialRoute: initialScreenRoute,
    );
  }
}
