import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inspireme/utils/approutes.dart';
import 'package:inspireme/utils/apptext.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/quote_provider.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(InspireMeApp());
}

class InspireMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuoteProvider(),
      child: Consumer<QuoteProvider>(
        builder: (context, quoteProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppText.InspireMeText,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: quoteProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}