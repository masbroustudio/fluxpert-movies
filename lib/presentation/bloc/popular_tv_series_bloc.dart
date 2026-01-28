import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_event_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc({required this.getPopularTvSeries})
      : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
  }

  Future<void> _onFetchPopularTvSeries(
    FetchPopularTvSeries event,
    Emitter<PopularTvSeriesState> emit,
  ) async {
    emit(PopularTvSeriesLoading());
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) => emit(PopularTvSeriesError(failure.message)),
      (tvSeriesData) => emit(PopularTvSeriesLoaded(tvSeriesData)),
    );
  }
}
