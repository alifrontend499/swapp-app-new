import 'package:flutter/material.dart';

// routes const
import 'package:app/theme/routing/routing_constants.dart';

// SCREENS
import 'package:app/screens/initials/index.dart';
// auth
import 'package:app/screens/auth/signup/index.dart';
import 'package:app/screens/auth/signup/steps/signupStep1.dart';
import 'package:app/screens/auth/signup/steps/signupStep2.dart';
import 'package:app/screens/auth/login/index.dart';
// main content
import 'package:app/screens/content/index.dart';
// vendor
import 'package:app/screens/vendorView/index.dart';
// messages
import 'package:app/screens/content/messagesContent/messagesView/index.dart';

// profile
import 'package:app/screens/userProfile/index.dart';


Route<dynamic> generateRoutes(RouteSettings settings) {
  switch(settings.name) {
    case initialScreenRoute:
      return MaterialPageRoute(builder: (context) => const InitialScreen());

    case signupScreenRoute:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case signupStep1ScreenRoute:
      return MaterialPageRoute(builder: (context) => const SignUpStep1Screen());

    case signupStep2ScreenRoute:
      return MaterialPageRoute(builder: (context) => const SignUpStep2Screen());

    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case contentMainScreenRoute:
      return MaterialPageRoute(builder: (context) => const ContentMainScreen());

    case vendorViewScreenRoute:
      return MaterialPageRoute(builder: (context) => const VendorViewScreen());

    case messagesViewScreenRoute:
      return MaterialPageRoute(builder: (context) => const MessagesViewScreen());

    case userProfileScreenRoute:
      return MaterialPageRoute(builder: (context) => const UserProfileScreen());

    default:
      return MaterialPageRoute(builder: (context) => const InitialScreen());
  }
}