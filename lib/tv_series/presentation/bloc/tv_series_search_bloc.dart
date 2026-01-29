import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/usecases/search_tv_series.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_search_event_state.dart';
import 'package:rxdart/rxdart.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc({required this.searchTvSeries})
      : super(TvSeriesSearchEmpty()) {
    on<OnQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<TvSeriesSearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(TvSeriesSearchEmpty());
      return;
    }

    emit(TvSeriesSearchLoading());
    final result = await searchTvSeries.execute(query);

    result.fold(
      (failure) => emit(TvSeriesSearchError(failure.message)),
      (data) => emit(TvSeriesSearchLoaded(data)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
