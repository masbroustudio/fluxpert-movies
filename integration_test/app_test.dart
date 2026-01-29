import 'package:ditonton/core/di/injection.dart' as di;
import 'package:ditonton/movie/presentation/pages/home_movie_page.dart';
import 'package:ditonton/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/core/common/about_page.dart';
import 'package:ditonton/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/tv_series/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Initialize dependency injection once
    di.init();
    await di.initHttpClient();
  });

  Widget createTestApp(Widget home) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<MovieListNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<MovieDetailNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<MovieSearchNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<PopularMoviesNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<TopRatedMoviesNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<WatchlistMovieNotifier>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.locator<OnTheAirTvSeriesBloc>()),
          BlocProvider(create: (_) => di.locator<PopularTvSeriesBloc>()),
          BlocProvider(create: (_) => di.locator<TopRatedTvSeriesBloc>()),
          BlocProvider(create: (_) => di.locator<TvSeriesDetailBloc>()),
          BlocProvider(create: (_) => di.locator<TvSeriesSearchBloc>()),
          BlocProvider(create: (_) => di.locator<TvSeriesWatchlistBloc>()),
        ],
        child: MaterialApp(
          home: home,
          theme: ThemeData.dark(),
        ),
      ),
    );
  }

  group('Movie Feature Integration Test', () {
    testWidgets('Movie home page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const HomeMoviePage()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify page loads
      expect(find.text('Ditonton'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      
      // Verify sections exist
      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('Can navigate to watchlist', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const WatchlistMoviesPage()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify watchlist page loads
      expect(find.text('Watchlist Movies'), findsOneWidget);
    });
  });

  group('TV Series Feature Integration Test', () {
    testWidgets('TV Series home page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const HomeTvSeriesPage()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify page loads
      expect(find.text('TV Series'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      
      // Verify sections exist
      expect(find.text('On The Air'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('Can navigate to TV Series watchlist', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const WatchlistTvSeriesPage()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify watchlist page loads
      expect(find.text('Watchlist TV Series'), findsOneWidget);
    });
  });

  group('About Page Integration Test', () {
    testWidgets('About page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const AboutPage(),
        theme: ThemeData.dark(),
      ));
      await tester.pumpAndSettle();

      // Verify about page loads
      expect(find.text('About'), findsAtLeastNWidgets(1));
    });
  });
}


