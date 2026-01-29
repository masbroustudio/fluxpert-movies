import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTvSeries(mockRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of on the air tv series from repository', () async {
    // arrange
    when(mockRepository.getOnTheAirTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
