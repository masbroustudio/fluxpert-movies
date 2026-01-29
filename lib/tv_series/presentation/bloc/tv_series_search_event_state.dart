import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends TvSeriesSearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

// States
abstract class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

class TvSeriesSearchEmpty extends TvSeriesSearchState {}

class TvSeriesSearchLoading extends TvSeriesSearchState {}

class TvSeriesSearchLoaded extends TvSeriesSearchState {
  final List<TvSeries> result;

  const TvSeriesSearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvSeriesSearchError extends TvSeriesSearchState {
  final String message;

  const TvSeriesSearchError(this.message);

  @override
  List<Object> get props => [message];
}
