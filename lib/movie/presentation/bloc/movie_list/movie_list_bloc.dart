import 'package:bloc/bloc.dart';
import 'package:ditonton/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:ditonton/movie/presentation/bloc/movie_list/movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieListBloc({required this.getNowPlayingMovies}) : super(MovieListEmpty()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoading());

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) => emit(MovieListError(failure.message)),
      (movies) => emit(MovieListLoaded(movies)),
    );
  }
}
