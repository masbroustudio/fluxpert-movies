import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockRepository);
  });

  final tTvSeries = <TvSeries>[];
  const tQuery = 'Breaking Bad';

  test('should get list of tv series from repository', () async {
    // arrange
    when(mockRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeries));
  });
}
