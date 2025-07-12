import 'package:flutter/material.dart';
import 'package:inspireme/utils/apptext.dart';
import 'package:inspireme/utils/colors.dart';
import 'package:inspireme/utils/dimensions.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';
import '../data/gradient_data.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context);
    final isDarkTheme = quoteProvider.isDarkTheme;

    final gradientIndex = quoteProvider.favorites.length % GradientData.lightGradients.length;
    final currentGradient =
        isDarkTheme
            ? GradientData.darkGradients[gradientIndex]
            : GradientData.lightGradients[gradientIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.favouriteNavBarText),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: currentGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:
            quoteProvider.favorites.isEmpty
                ? Center(
                  child: Text(
                    AppText.noFavourite,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
                    ),
                  ),
                )
                : Padding(
                  padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: kToolbarHeight + 24, // AppBar height + some spacing
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    itemCount: quoteProvider.favorites.length,
                    itemBuilder: (context, index) {
                      final quote = quoteProvider.favorites[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                        elevation: Dimensions.RADIUS_SMALL,
                        color:
                            isDarkTheme
                                ? Colors.black.withOpacity(0.4)
                                : Colors.white.withOpacity(0.85),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT, horizontal: Dimensions.PADDING_SIZE_LARGE),
                          title: Text(
                            '"${quote.text}"',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                              '- ${quote.author}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite, color: AppColors.redColor),
                            onPressed: () async {
                              // Toggle favorite
                              quoteProvider.toggleFavorite(quote);

                              // Play the like sound
                              final player = AudioPlayer();
                              await player.setReleaseMode(ReleaseMode.stop);
                              await player.setSource(AssetSource('like.mp3'));
                              await player.resume();
                            },
                          ),
                        ),
                      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
                    },
                  ),
                ),
      ),
    );
  }
}
