import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_event_state.dart';

class OnTheAirTvSeriesBloc
    extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;

  OnTheAirTvSeriesBloc({required this.getOnTheAirTvSeries})
      : super(OnTheAirTvSeriesEmpty()) {
    on<FetchOnTheAirTvSeries>(_onFetchOnTheAirTvSeries);
  }

  Future<void> _onFetchOnTheAirTvSeries(
    FetchOnTheAirTvSeries event,
    Emitter<OnTheAirTvSeriesState> emit,
  ) async {
    emit(OnTheAirTvSeriesLoading());
    final result = await getOnTheAirTvSeries.execute();
    result.fold(
      (failure) => emit(OnTheAirTvSeriesError(failure.message)),
      (tvSeriesData) => emit(OnTheAirTvSeriesLoaded(tvSeriesData)),
    );
  }
}
