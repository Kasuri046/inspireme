import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/approutes.dart';

class Wrappers extends StatefulWidget {
  const Wrappers({super.key});

  @override
  State<Wrappers> createState() => _WrappersState();
}

class _WrappersState extends State<Wrappers> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      // Delay navigation to ensure safe context
      await Future.delayed(Duration.zero);
      if (!mounted) return;

      if (user == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        await user.reload(); // Refresh user data
        if (user.emailVerified) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.emailVerification);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
