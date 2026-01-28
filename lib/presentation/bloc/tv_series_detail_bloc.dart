import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_event_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetWatchlistTvSeriesStatus getWatchlistStatus;
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTvSeriesWatchlist removeWatchlist;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvSeriesDetailEmpty()) {
    on<FetchTvSeriesDetail>(_onFetchTvSeriesDetail);
    on<AddTvSeriesToWatchlist>(_onAddToWatchlist);
    on<RemoveTvSeriesFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadTvSeriesWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchTvSeriesDetail(
    FetchTvSeriesDetail event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    emit(TvSeriesDetailLoading());
    final detailResult = await getTvSeriesDetail.execute(event.id);
    final watchlistStatus = await getWatchlistStatus.execute(event.id);

    detailResult.fold(
      (failure) => emit(TvSeriesDetailError(failure.message)),
      (tvSeries) => emit(TvSeriesDetailLoaded(
        tvSeries,
        isAddedToWatchlist: watchlistStatus,
      )),
    );
  }

  Future<void> _onAddToWatchlist(
    AddTvSeriesToWatchlist event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.tvSeriesDetail);
    result.fold(
      (failure) => emit(TvSeriesDetailError(failure.message)),
      (successMessage) {
        emit(TvSeriesWatchlistMessage(successMessage));
        add(FetchTvSeriesDetail(event.tvSeriesDetail.id));
      },
    );
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveTvSeriesFromWatchlist event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.tvSeriesDetail);
    result.fold(
      (failure) => emit(TvSeriesDetailError(failure.message)),
      (successMessage) {
        emit(TvSeriesWatchlistMessage(successMessage));
        add(FetchTvSeriesDetail(event.tvSeriesDetail.id));
      },
    );
  }

  Future<void> _onLoadWatchlistStatus(
    LoadTvSeriesWatchlistStatus event,
    Emitter<TvSeriesDetailState> emit,
  ) async {
    final result = await getWatchlistStatus.execute(event.id);
    if (state is TvSeriesDetailLoaded) {
      final currentState = state as TvSeriesDetailLoaded;
      emit(currentState.copyWith(isAddedToWatchlist: result));
    }
  }
}
