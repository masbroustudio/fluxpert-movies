import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_event_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc({
    required this.getOnTheAirTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(TvSeriesListEmpty()) {
    on<FetchOnTheAirTvSeries>(_onFetchOnTheAirTvSeries);
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  Future<void> _onFetchOnTheAirTvSeries(
    FetchOnTheAirTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(OnTheAirTvSeriesLoading());
    final result = await getOnTheAirTvSeries.execute();
    result.fold(
      (failure) => emit(OnTheAirTvSeriesError(failure.message)),
      (tvSeriesData) => emit(OnTheAirTvSeriesLoaded(tvSeriesData)),
    );
  }

  Future<void> _onFetchPopularTvSeries(
    FetchPopularTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(PopularTvSeriesLoading());
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) => emit(PopularTvSeriesError(failure.message)),
      (tvSeriesData) => emit(PopularTvSeriesLoaded(tvSeriesData)),
    );
  }

  Future<void> _onFetchTopRatedTvSeries(
    FetchTopRatedTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(TopRatedTvSeriesLoading());
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) => emit(TopRatedTvSeriesError(failure.message)),
      (tvSeriesData) => emit(TopRatedTvSeriesLoaded(tvSeriesData)),
    );
  }
}
