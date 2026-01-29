import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_event_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvSeries])
void main() {
  late OnTheAirTvSeriesBloc bloc;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;

  setUp(() {
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    bloc = OnTheAirTvSeriesBloc(getOnTheAirTvSeries: mockGetOnTheAirTvSeries);
  });

  test('initial state should be empty', () {
    expect(bloc.state, OnTheAirTvSeriesEmpty());
  });

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'should emit [Loading, Loaded] when data is fetched successfully',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      OnTheAirTvSeriesLoading(),
      OnTheAirTvSeriesLoaded(testTvSeriesList),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'should emit [Loading, Error] when fetch fails',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      OnTheAirTvSeriesLoading(),
      const OnTheAirTvSeriesError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvSeries.execute());
    },
  );
}
