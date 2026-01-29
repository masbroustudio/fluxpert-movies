import 'package:bloc/bloc.dart';
import 'package:ditonton/movie/domain/usecases/search_movies.dart';
import 'package:ditonton/movie/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:ditonton/movie/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:rxdart/rxdart.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<ClearSearch>(_onClearSearch);
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<MovieSearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(MovieSearchEmpty());
      return;
    }

    emit(MovieSearchLoading());

    final result = await searchMovies.execute(query);

    result.fold(
      (failure) => emit(MovieSearchError(failure.message)),
      (movies) => emit(MovieSearchLoaded(movies)),
    );
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<MovieSearchState> emit,
  ) {
    emit(MovieSearchEmpty());
  }
}
