import 'package:bloc/bloc.dart';
import 'package:ditonton/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/movie/presentation/bloc/watchlist_movie/watchlist_movie_event.dart';
import 'package:ditonton/movie/presentation/bloc/watchlist_movie/watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies}) : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovies>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
    FetchWatchlistMovies event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(WatchlistMovieLoading());

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) => emit(WatchlistMovieError(failure.message)),
      (movies) => emit(WatchlistMovieLoaded(movies)),
    );
  }
}
