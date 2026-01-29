import 'package:bloc/bloc.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail_event_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<AddMovieToWatchlist>(_onAddToWatchlist);
    on<RemoveMovieFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadMovieWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(event.id);
    final watchlistStatus = await getWatchlistStatus.execute(event.id);

    detailResult.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (movie) => emit(MovieDetailLoaded(
        movie,
        isAddedToWatchlist: watchlistStatus,
      )),
    );
  }

  Future<void> _onAddToWatchlist(
    AddMovieToWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movieDetail);
    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (successMessage) {
        emit(MovieWatchlistMessage(successMessage));
        add(FetchMovieDetail(event.movieDetail.id));
      },
    );
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveMovieFromWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movieDetail);
    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (successMessage) {
        emit(MovieWatchlistMessage(successMessage));
        add(FetchMovieDetail(event.movieDetail.id));
      },
    );
  }

  Future<void> _onLoadWatchlistStatus(
    LoadMovieWatchlistStatus event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getWatchlistStatus.execute(event.id);
    if (state is MovieDetailLoaded) {
      final currentState = state as MovieDetailLoaded;
      emit(currentState.copyWith(isAddedToWatchlist: result));
    }
  }
}
