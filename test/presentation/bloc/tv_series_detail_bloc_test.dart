import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_detail_event_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetWatchlistTvSeriesStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesDetailBloc bloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistStatus;
  late MockSaveTvSeriesWatchlist mockSaveWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetWatchlistStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveWatchlist = MockRemoveTvSeriesWatchlist();
    bloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getWatchlistStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1396;

  test('initial state should be empty', () {
    expect(bloc.state, TvSeriesDetailEmpty());
  });

  group('Get TvSeries Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Loaded] when detail data is fetched successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvSeriesDetail));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        TvSeriesDetailLoading(),
        const TvSeriesDetailLoaded(
          testTvSeriesDetail,
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Error] when detail fetch fails',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        TvSeriesDetailLoading(),
        const TvSeriesDetailError('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );
  });

  group('Add to Watchlist', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit success message when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => true);
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvSeriesDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddTvSeriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesWatchlistMessage('Added to Watchlist'),
        TvSeriesDetailLoading(),
        const TvSeriesDetailLoaded(
          testTvSeriesDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvSeriesDetail));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit error when add watchlist fails',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddTvSeriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesDetailError('Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvSeriesDetail));
      },
    );
  });

  group('Remove from Watchlist', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit success message when remove watchlist success',
      build: () {
        when(mockRemoveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvSeriesDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(const RemoveTvSeriesFromWatchlist(testTvSeriesDetail)),
      expect: () => [
        const TvSeriesWatchlistMessage('Removed from Watchlist'),
        TvSeriesDetailLoading(),
        const TvSeriesDetailLoaded(
          testTvSeriesDetail,
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvSeriesDetail));
      },
    );
  });
}
