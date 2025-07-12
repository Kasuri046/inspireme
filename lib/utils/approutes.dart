import 'package:flutter/material.dart';
import 'package:inspireme/utils/apptext.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/splash_screen.dart'; // <-- Add this

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String favorites = AppText.routeFavourite;

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    home: (context) => HomeScreen(),
    favorites: (context) => FavoritesScreen(),
  };
}
