import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TvSeriesListEvent extends Equatable {
  const TvSeriesListEvent();

  @override
  List<Object> get props => [];
}

class FetchOnTheAirTvSeries extends TvSeriesListEvent {}

class FetchPopularTvSeries extends TvSeriesListEvent {}

class FetchTopRatedTvSeries extends TvSeriesListEvent {}

// States
abstract class TvSeriesListState extends Equatable {
  const TvSeriesListState();

  @override
  List<Object> get props => [];
}

class TvSeriesListEmpty extends TvSeriesListState {}

class TvSeriesListLoading extends TvSeriesListState {}

class TvSeriesListError extends TvSeriesListState {
  final String message;

  const TvSeriesListError(this.message);

  @override
  List<Object> get props => [message];
}

// Partial states for individual lists
class OnTheAirTvSeriesLoading extends TvSeriesListState {}

class OnTheAirTvSeriesLoaded extends TvSeriesListState {
  final List<TvSeries> tvSeries;

  const OnTheAirTvSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class OnTheAirTvSeriesError extends TvSeriesListState {
  final String message;

  const OnTheAirTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvSeriesLoading extends TvSeriesListState {}

class PopularTvSeriesLoaded extends TvSeriesListState {
  final List<TvSeries> tvSeries;

  const PopularTvSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class PopularTvSeriesError extends TvSeriesListState {
  final String message;

  const PopularTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvSeriesLoading extends TvSeriesListState {}

class TopRatedTvSeriesLoaded extends TvSeriesListState {
  final List<TvSeries> tvSeries;

  const TopRatedTvSeriesLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class TopRatedTvSeriesError extends TvSeriesListState {
  final String message;

  const TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
