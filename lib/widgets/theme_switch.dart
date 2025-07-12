import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context);

    return IconButton(
      icon: Icon(
        quoteProvider.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: () async{
        final player = AudioPlayer();
        await player.setReleaseMode(ReleaseMode.stop);
        await player.setSource(AssetSource('nextscreen.mp3'));
        await player.resume();
        quoteProvider.toggleTheme();

      },
    );
  }
}