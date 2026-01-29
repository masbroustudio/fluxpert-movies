import 'package:ditonton/core/common/constants.dart';
import 'package:ditonton/core/common/utils.dart';
import 'package:ditonton/core/utils/firebase_service.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/core/common/about_page.dart';
import 'package:ditonton/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/movie/presentation/pages/home_movie_page.dart';
import 'package:ditonton/tv_series/presentation/pages/on_the_air_tv_series_page.dart';
import 'package:ditonton/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/movie/presentation/pages/search_page.dart';
import 'package:ditonton/tv_series/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/tv_series/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/core/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await FirebaseService.initialize();
  
  // Initialize dependency injection
  di.init();
  await di.initHttpClient(); // Initialize SSL Pinning
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeTvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvSeriesPage());
            case OnTheAirTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const OnTheAirTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchTvSeriesPage());
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistTvSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
