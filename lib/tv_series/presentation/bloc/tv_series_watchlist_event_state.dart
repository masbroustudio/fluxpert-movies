import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesWatchlist extends TvSeriesWatchlistEvent {}

// States
abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoaded extends TvSeriesWatchlistState {
  final List<TvSeries> watchlist;

  const TvSeriesWatchlistLoaded(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}
