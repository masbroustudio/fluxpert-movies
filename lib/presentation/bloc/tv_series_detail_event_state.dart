import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  const FetchTvSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvSeriesToWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddTvSeriesToWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveTvSeriesFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesFromWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class LoadTvSeriesWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  const LoadTvSeriesWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

// States
abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailEmpty extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;
  final bool isAddedToWatchlist;

  const TvSeriesDetailLoaded(
    this.tvSeriesDetail, {
    this.isAddedToWatchlist = false,
  });

  TvSeriesDetailLoaded copyWith({
    TvSeriesDetail? tvSeriesDetail,
    bool? isAddedToWatchlist,
  }) {
    return TvSeriesDetailLoaded(
      tvSeriesDetail ?? this.tvSeriesDetail,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object> get props => [tvSeriesDetail, isAddedToWatchlist];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistMessage extends TvSeriesDetailState {
  final String message;

  const TvSeriesWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
