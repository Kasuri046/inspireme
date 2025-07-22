import 'package:flutter/material.dart';
import 'package:inspireme/auth/signup_screen.dart';
import 'package:inspireme/utils/apptext.dart';
import '../auth/email_verificaton_screen.dart';
import '../auth/login_screen.dart';
import '../auth/widgets/wrappers.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/splash_screen.dart'; // <-- A  dd this

class AppRoutes {
  static const String splash = AppText.routeSplash;
  static const String wrapper = AppText.routeWrapper;
  static const String login = AppText.routeLogin;
  static const String signup = AppText.routeSignUp;
  static const String emailVerification = AppText.routeEmailVerification;
  static const String home = AppText.routeHome;
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
