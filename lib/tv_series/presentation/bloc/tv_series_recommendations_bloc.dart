import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TvSeriesRecommendationsEvent extends Equatable {
  const TvSeriesRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesRecommendations extends TvSeriesRecommendationsEvent {
  final int id;

  const FetchTvSeriesRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

// States
abstract class TvSeriesRecommendationsState extends Equatable {
  const TvSeriesRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationsEmpty extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsLoading extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsLoaded extends TvSeriesRecommendationsState {
  final List<TvSeries> recommendations;

  const TvSeriesRecommendationsLoaded(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

class TvSeriesRecommendationsError extends TvSeriesRecommendationsState {
  final String message;

  const TvSeriesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class TvSeriesRecommendationsBloc extends Bloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationsBloc({
    required this.getTvSeriesRecommendations,
  }) : super(TvSeriesRecommendationsEmpty()) {
    on<FetchTvSeriesRecommendations>(_onFetchRecommendations);
  }

  Future<void> _onFetchRecommendations(
    FetchTvSeriesRecommendations event,
    Emitter<TvSeriesRecommendationsState> emit,
  ) async {
    emit(TvSeriesRecommendationsLoading());
    
    final result = await getTvSeriesRecommendations.execute(event.id);
    
    result.fold(
      (failure) => emit(TvSeriesRecommendationsError(failure.message)),
      (tvSeries) => emit(TvSeriesRecommendationsLoaded(tvSeries)),
    );
  }
}
