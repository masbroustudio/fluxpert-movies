import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class PopularTvSeriesEvent extends Equatable {
  const PopularTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularTvSeries extends PopularTvSeriesEvent {}

// States
abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesEmpty extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {}

class PopularTvSeriesLoaded extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  const PopularTvSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  const PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
