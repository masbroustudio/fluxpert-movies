import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static FirebaseAnalytics? _analytics;
  static FirebaseCrashlytics? _crashlytics;

  static FirebaseAnalytics get analytics {
    if (_analytics == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _analytics!;
  }

  static FirebaseCrashlytics get crashlytics {
    if (_crashlytics == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _crashlytics!;
  }

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _analytics = FirebaseAnalytics.instance;
      _crashlytics = FirebaseCrashlytics.instance;

      // Configure Crashlytics
      await _crashlytics!.setCrashlyticsCollectionEnabled(!kDebugMode);

      // Pass all uncaught errors from Flutter framework to Crashlytics
      FlutterError.onError = _crashlytics!.recordFlutterFatalError;

      // Pass all uncaught asynchronous errors to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        _crashlytics!.recordError(error, stack, fatal: true);
        return true;
      };

      if (kDebugMode) {
        print('✅ Firebase initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Firebase initialization failed: $e');
      }
      rethrow;
    }
  }

  // Analytics: Log screen view
  static Future<void> logScreenView(String screenName) async {
    try {
      await _analytics?.logScreenView(screenName: screenName);
    } catch (e) {
      if (kDebugMode) {
        print('Analytics error: $e');
      }
    }
  }

  // Analytics: Log custom event
  static Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics?.logEvent(name: name, parameters: parameters);
    } catch (e) {
      if (kDebugMode) {
        print('Analytics error: $e');
      }
    }
  }

  // Analytics: Log movie viewed
  static Future<void> logMovieViewed(int movieId, String movieTitle) async {
    await logEvent(
      name: 'movie_viewed',
      parameters: {
        'movie_id': movieId,
        'movie_title': movieTitle,
      },
    );
  }

  // Analytics: Log TV series viewed
  static Future<void> logTvSeriesViewed(int tvId, String tvTitle) async {
    await logEvent(
      name: 'tv_series_viewed',
      parameters: {
        'tv_id': tvId,
        'tv_title': tvTitle,
      },
    );
  }

  // Analytics: Log watchlist action
  static Future<void> logWatchlistAction({
    required String action,
    required String type,
    required int itemId,
    required String itemTitle,
  }) async {
    await logEvent(
      name: action == 'add' ? 'add_to_watchlist' : 'remove_from_watchlist',
      parameters: {
        'content_type': type,
        'item_id': itemId,
        'item_title': itemTitle,
      },
    );
  }

  // Analytics: Log search performed
  static Future<void> logSearchPerformed(String query, String type) async {
    await logEvent(
      name: 'search_performed',
      parameters: {
        'search_query': query,
        'search_type': type,
      },
    );
  }

  // Crashlytics: Log custom error
  static Future<void> logError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    try {
      await _crashlytics?.recordError(
        exception,
        stackTrace,
        reason: reason,
        fatal: fatal,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Crashlytics error: $e');
      }
    }
  }

  // Crashlytics: Set custom key
  static Future<void> setCustomKey(String key, dynamic value) async {
    try {
      await _crashlytics?.setCustomKey(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('Crashlytics error: $e');
      }
    }
  }

  // Crashlytics: Set user identifier
  static Future<void> setUserId(String userId) async {
    try {
      await _crashlytics?.setUserIdentifier(userId);
    } catch (e) {
      if (kDebugMode) {
        print('Crashlytics error: $e');
      }
    }
  }

  // Test crash (only for testing)
  static void testCrash() {
    if (kDebugMode) {
      print('⚠️ Test crash triggered!');
    }
    throw Exception('Test crash from Firebase');
  }
}
