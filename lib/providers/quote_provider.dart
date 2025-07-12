import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/quotes_data.dart';
import '../model/quote.dart';
import 'dart:math';

class QuoteProvider with ChangeNotifier {

  // => Dark Theme
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  // => Current Quote
  Quote _currentQuote = Quote(text: '', author: '');
  Quote get currentQuote => _currentQuote;
  void getNewQuote() {
    final random = Random();
    _currentQuote = quotes[random.nextInt(quotes.length)];
    notifyListeners();
  }

  // Favorite Quotes
  List<Quote> _favorites = [];
  List<Quote> get favorites => _favorites;

  void toggleFavorite(Quote quote) async {
    if (_favorites.any((q) => q.text == quote.text)) {
      _favorites.removeWhere((q) => q.text == quote.text);
    } else {
      _favorites.add(quote);
    }
    await saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Quote quote) {
    return _favorites.any((q) => q.text == quote.text);
  }

  // Save favorites to local storage
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = _favorites.map((q) => q.toJson()).toList();
    await prefs.setStringList(
      'favorites',
      favoriteList.map((q) => jsonEncode(q)).toList(),
    );
  }

  //  Load favorites from local storage
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorites') ?? [];
    _favorites = favoriteList
        .map((q) => Quote.fromJson(jsonDecode(q)))
        .toList();
    notifyListeners();
  }

  // Constructor
  QuoteProvider() {
    loadFavorites();
    getNewQuote();
  }
}
