// import 'package:firebase_analytics/firebase_analytics.dart';
//
// class AnalyticsService {
//   static final AnalyticsService _instance = AnalyticsService._internal();
//   factory AnalyticsService() => _instance;
//   AnalyticsService._internal();
//
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//
//   Future<void> logEvent(String eventName, {Map<String, Object>? parameters}) async {
//     await _analytics.logEvent(
//       name: eventName,
//       parameters: parameters,
//     );
//   }
//
//   Future<void> logScreenView(String screenName) async {
//     await _analytics.logScreenView(
//       screenName: screenName,
//       screenClass: screenName,
//     );
//   }
// }
