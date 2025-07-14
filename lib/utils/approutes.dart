import 'package:flutter/material.dart';
import 'package:inspireme/auth/signup_screen.dart';
import 'package:inspireme/utils/apptext.dart';
import '../auth/email_verificaton_screen.dart';
import '../auth/login_screen.dart';
import '../auth/widgets/wrappers.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/splash_screen.dart'; // <-- Add this

class AppRoutes {
  static const String splash = '/';
  static const String wrapper = '/wrapper';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String emailVerification = '/emailVerification';
  static const String home = '/home';
  static const String favorites = AppText.routeFavourite;

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    wrapper: (context) => Wrappers(),
    login: (context) => LoginScreen(),
    signup: (context) => SignupScreen(),
    emailVerification: (context) => EmailVerificationScreen(),
    home: (context) => HomeScreen(),
    favorites: (context) => FavoritesScreen(),
  };
}
