import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_event_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  TvSeriesWatchlistBloc({required this.getWatchlistTvSeries})
      : super(TvSeriesWatchlistEmpty()) {
    on<FetchTvSeriesWatchlist>(_onFetchWatchlist);
  }

  Future<void> _onFetchWatchlist(
    FetchTvSeriesWatchlist event,
    Emitter<TvSeriesWatchlistState> emit,
  ) async {
    emit(TvSeriesWatchlistLoading());
    final result = await getWatchlistTvSeries.execute();

    result.fold(
      (failure) => emit(TvSeriesWatchlistError(failure.message)),
      (data) => emit(TvSeriesWatchlistLoaded(data)),
    );
  }
}
