import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_event_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistBloc bloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    bloc = TvSeriesWatchlistBloc(getWatchlistTvSeries: mockGetWatchlistTvSeries);
  });

  test('initial state should be empty', () {
    expect(bloc.state, TvSeriesWatchlistEmpty());
  });

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'should emit [Loading, Loaded] when watchlist is fetched successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesWatchlist()),
    expect: () => [
      TvSeriesWatchlistLoading(),
      TvSeriesWatchlistLoaded(testTvSeriesList),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
    'should emit [Loading, Error] when fetch fails',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Left(DatabaseFailure('Database Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesWatchlist()),
    expect: () => [
      TvSeriesWatchlistLoading(),
      const TvSeriesWatchlistError('Database Failure'),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
