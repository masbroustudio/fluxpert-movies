import 'package:ditonton/core/database/database_helper.dart';
import 'package:ditonton/core/network/secure_http_client.dart';
import 'package:ditonton/movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/movie/domain/usecases/search_movies.dart';
import 'package:ditonton/tv_series/domain/usecases/search_tv_series.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc - Movies
  locator.registerFactory(
    () => MovieListBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
    ),
  );

  // bloc - TV Series
  locator.registerFactory(
    () => OnTheAirTvSeriesBloc(
      getOnTheAirTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      getTvSeriesDetail: locator(),
      getWatchlistStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesWatchlistBloc(
      getWatchlistTvSeries: locator(),
    ),
  );

  // use case - Movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case - TV Series
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository - Movies
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository - TV Series
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources - Movies
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources - TV Series
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external - HTTP client (will be initialized with SSL Pinning in main)
  locator.registerLazySingleton(() => http.Client());
}

// Initialize HTTP Client with SSL Pinning
Future<void> initHttpClient() async {
  final secureClient = await SecureHttpClient.createSecureClient();
  if (locator.isRegistered<http.Client>()) {
    locator.unregister<http.Client>();
  }
  locator.registerLazySingleton<http.Client>(() => secureClient);
}
