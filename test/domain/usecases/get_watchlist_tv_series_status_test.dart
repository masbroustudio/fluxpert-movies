import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeriesStatus usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeriesStatus(mockRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockRepository.isAddedToWatchlist(1396))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1396);
    // assert
    expect(result, true);
  });
}
