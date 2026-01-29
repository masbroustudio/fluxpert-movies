import 'package:bloc/bloc.dart';
import 'package:ditonton/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/movie/presentation/bloc/popular_movies_event_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesEmpty()) {
    on<FetchPopularMovies>(_onFetchPopularMovies);
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMovies event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(PopularMoviesError(failure.message)),
      (moviesData) => emit(PopularMoviesLoaded(moviesData)),
    );
  }
}
