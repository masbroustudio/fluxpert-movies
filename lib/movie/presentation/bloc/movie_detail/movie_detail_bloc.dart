import 'package:bloc/bloc.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());

    final result = await getMovieDetail.execute(event.id);

    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (movie) => emit(MovieDetailLoaded(movie)),
    );
  }
}

class MovieRecommendationsBloc extends Bloc<MovieDetailEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsBloc({
    required this.getMovieRecommendations,
  }) : super(MovieRecommendationsEmpty()) {
    on<FetchMovieDetail>(_onFetchMovieRecommendations);
  }

  Future<void> _onFetchMovieRecommendations(
    FetchMovieDetail event,
    Emitter<MovieRecommendationsState> emit,
  ) async {
    emit(MovieRecommendationsLoading());

    final result = await getMovieRecommendations.execute(event.id);

    result.fold(
      (failure) => emit(MovieRecommendationsError(failure.message)),
      (movies) => emit(MovieRecommendationsLoaded(movies)),
    );
  }
}

class MovieWatchlistBloc extends Bloc<MovieDetailEvent, WatchlistStatus> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const WatchlistStatus(false)) {
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<WatchlistStatus> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(WatchlistStatus(result));
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<WatchlistStatus> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);

    result.fold(
      (failure) => emit(const WatchlistStatus(false)),
      (successMessage) => emit(const WatchlistStatus(true)),
    );
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<WatchlistStatus> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);

    result.fold(
      (failure) => emit(const WatchlistStatus(true)),
      (successMessage) => emit(const WatchlistStatus(false)),
    );
  }
}
