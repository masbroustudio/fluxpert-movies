import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = RemoveTvSeriesWatchlist(mockRepository);
  });

  test('should remove tv series from repository', () async {
    // arrange
    when(mockRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockRepository.removeWatchlist(testTvSeriesDetail));
    expect(result, const Right('Removed from Watchlist'));
  });
}
