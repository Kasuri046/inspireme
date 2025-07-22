import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:inspireme/utils/colors.dart';
import 'package:inspireme/utils/dimensions.dart';
import 'package:provider/provider.dart';
import '../auth/auth_services_screen.dart';
import '../providers/quote_provider.dart';
import '../utils/analytics_service.dart';
import '../utils/apptext.dart';
import '../widgets/theme_switch.dart';
import '../data/gradient_data.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:inspireme/utils/approutes.dart';

class HomeScreen extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context);
    final isDarkTheme = quoteProvider.isDarkTheme;

    // // 🔥 Log screen view
    // AnalyticsService().logScreenView('HomeScreen');

    final gradientIndex =
        quoteProvider.currentQuote.text.hashCode.abs() % GradientData.lightGradients.length;
    final currentGradient =
        isDarkTheme
            ? GradientData.darkGradients[gradientIndex]
            : GradientData.lightGradients[gradientIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppText.InspireMeText,
          style: TextStyle(
            fontSize: Dimensions.fontSizeExtraLarge + 2,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
        actions: [
          ThemeSwitch(),
          Hero(
            tag: 'favorite-icon',
            child: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () async {
                final player = AudioPlayer();
                await player.setReleaseMode(ReleaseMode.stop);
                await player.setSource(AssetSource('nextscreen.mp3'));
                await player.resume();
                await Future.delayed(Duration(milliseconds: 300));
                Navigator.pushNamed(context, AppText.routeFavourite);
              },
            ),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: currentGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                quoteProvider.currentQuote.text.isNotEmpty
                    ? Text(
                          '"${quoteProvider.currentQuote.text}"',
                          key: ValueKey(quoteProvider.currentQuote.text),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate(key: ValueKey(quoteProvider.currentQuote.text))
                        .fadeIn(duration: 1000.ms, curve: Curves.easeInOut)
                        .slideY(begin: 0.3, end: 0, duration: 1000.ms, curve: Curves.easeInOut)
                    : Text(
                      AppText.InspireMeText,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                SizedBox(height: Dimensions.fontSizeLarge),
                quoteProvider.currentQuote.author.isNotEmpty
                    ? Text(
                          '- ${quoteProvider.currentQuote.author}',
                          key: ValueKey(quoteProvider.currentQuote.author),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
                          ),
                        )
                        .animate(key: ValueKey(quoteProvider.currentQuote.author))
                        .fadeIn(duration: 1000.ms, curve: Curves.easeInOut)
                        .slideY(begin: 0.3, end: 0, duration: 1000.ms, curve: Curves.easeInOut)
                    : SizedBox.shrink(),
                SizedBox(height: Dimensions.fontSizeLarge),
                // Share + Like buttons in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Share button
                    IconButton(
                      icon: Icon(Icons.share),
                      color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
                      onPressed: () {
                        final quote = quoteProvider.currentQuote;
                        final quoteText = quote.text.trim();
                        final author = quote.author.trim();

                        if (quoteText.isNotEmpty) {
                          final shareText =
                              author.isNotEmpty ? '"$quoteText"\n\n- $author' : '"$quoteText"';
                          Share.share(shareText);

                          // 🔥 Analytics
                          // AnalyticsService().logEvent('quote_shared', parameters: {
                          //   'text': quoteText,
                          //   'author': author,
                          // });


                        }
                      },
                    ),
                    // Like button
                    IconButton(
                      icon: Icon(
                        quoteProvider.isFavorite(quoteProvider.currentQuote)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            quoteProvider.isFavorite(quoteProvider.currentQuote)
                                ? AppColors.redColor
                                : null,
                      ),
                      onPressed: () async {
                        quoteProvider.toggleFavorite(quoteProvider.currentQuote);
                        final player = AudioPlayer();
                        await player.setReleaseMode(ReleaseMode.stop);
                        try {
                          await player.setSource(AssetSource('like.mp3'));
                          await player.resume();
                        } catch (e) {
                          debugPrint('$e');

                          // //  🔥  Analytics
                          // AnalyticsService().logEvent('quote_liked', parameters: {
                          //   'text': quoteProvider.currentQuote.text,
                          //   'author': quoteProvider.currentQuote.author,
                          // });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.fontSizeLarge),
                FloatingActionButton(
                  onPressed: ()  {
                    FirebaseCrashlytics.instance.crash();
                  },
                  child: Icon(Icons.bug_report),
                  backgroundColor: isDarkTheme ? AppColors.darkTheme : AppColors.lightTheme,
                ),
                SizedBox(height: Dimensions.fontSizeLarge,),
                FloatingActionButton(
                  onPressed: () async {
                    try {
                      await _auth.signout();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text(AppText.homeScreenLogOut)));
                      Navigator.pushReplacementNamed(context, AppRoutes.login);

                      // // 🔥 Analytics
                      // AnalyticsService().logEvent('user_logout');

                    } catch (e, stackTrace) {
                      // ✅ Log the exception to Firebase Crashlytics
                      await FirebaseCrashlytics.instance.recordError(
                        e,
                        stackTrace,
                        reason: 'Logout button failed',
                      );
                      debugPrint('$e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(AppText.homeScreenError)),
                      );
                    }
                  },
                  child: Icon(Icons.logout),
                  backgroundColor: isDarkTheme ? AppColors.darkTheme : AppColors.lightTheme,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final player = AudioPlayer();
          await player.setReleaseMode(ReleaseMode.stop);
          await player.setSource(AssetSource('music.mp3'));
          player.resume();
          quoteProvider.getNewQuote();

          // // 🔥 Analytics
          // AnalyticsService().logEvent('new_quote_generated');

        },
        label: Text(
          AppText.InspireMeText,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: Dimensions.fontSizeExtraLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkTheme ? AppColors.darkTheme : AppColors.lightTheme,
      ),
    );
  }
}
