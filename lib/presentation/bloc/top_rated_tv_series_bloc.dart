import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_event_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc({required this.getTopRatedTvSeries})
      : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  Future<void> _onFetchTopRatedTvSeries(
    FetchTopRatedTvSeries event,
    Emitter<TopRatedTvSeriesState> emit,
  ) async {
    emit(TopRatedTvSeriesLoading());
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) => emit(TopRatedTvSeriesError(failure.message)),
      (tvSeriesData) => emit(TopRatedTvSeriesLoaded(tvSeriesData)),
    );
  }
}
