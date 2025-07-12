import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inspireme/utils/appimages.dart';
import 'package:inspireme/utils/approutes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to home screen after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // white background
      body: Center(
        child: Image.asset(
          AppImages.splash,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
