import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // FireBase Firestore for Favorites
  // Favorite Quotes
  List<Quote> _favorites = [];
  List<Quote> get favorites => _favorites;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void toggleFavorite(Quote quote) async {
    try {
      final quoteRef = _firestore.collection('favorites').doc(quote.text.hashCode.toString());

      if (_favorites.any((q) => q.text == quote.text)) {
        // Remove from Firestore and local list
        await quoteRef.delete();
        _favorites.removeWhere((q) => q.text == quote.text);
      } else {
        // Add to Firestore and local list
        await quoteRef.set({
          'text': quote.text,
          'author': quote.author,
        });
        _favorites.add(quote);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  bool isFavorite(Quote quote) {
    return _favorites.any((q) => q.text == quote.text);
  }

  // Load favorites from Firestore
  Future<void> loadFavorites() async {
    try {
      final snapshot = await _firestore.collection('favorites').get();
      _favorites = snapshot.docs.map((doc) {
        final data = doc.data();
        return Quote(
          text: data['text'] ?? '',
          author: data['author'] ?? '',
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }


  //Shared Predferences for Favorites//
  // // Favorite Quotes
  // List<Quote> _favorites = [];
  // List<Quote> get favorites => _favorites;
  //
  // void toggleFavorite(Quote quote) async {
  //   if (_favorites.any((q) => q.text == quote.text)) {
  //     _favorites.removeWhere((q) => q.text == quote.text);
  //   } else {
  //     _favorites.add(quote);
  //   }
  //   await saveFavorites();
  //   notifyListeners();
  // }
  //
  // bool isFavorite(Quote quote) {
  //   return _favorites.any((q) => q.text == quote.text);
  // }
  //
  // // Save favorites to local storage
  // Future<void> saveFavorites() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favoriteList = _favorites.map((q) => q.toJson()).toList();
  //   await prefs.setStringList(
  //     'favorites',
  //     favoriteList.map((q) => jsonEncode(q)).toList(),
  //   );
  // }
  //
  // //  Load favorites from local storage
  // Future<void> loadFavorites() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favoriteList = prefs.getStringList('favorites') ?? [];
  //   _favorites = favoriteList
  //       .map((q) => Quote.fromJson(jsonDecode(q)))
  //       .toList();
  //   notifyListeners();
  // }

  //

  // Constructor
  QuoteProvider() {
    loadFavorites();
    getNewQuote();
  }
}
