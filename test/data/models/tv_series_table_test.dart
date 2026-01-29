import 'package:ditonton/tv_series/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return a valid entity from table', () async {
    // act
    final result = testTvSeriesTable.toEntity();
    
    // assert
    expect(result, testWatchlistTvSeries);
  });

  test('should return a JSON map containing proper data', () async {
    // act
    final result = testTvSeriesTable.toJson();
    
    // assert
    expect(result, testTvSeriesMap);
  });

  test('should return a table from entity', () async {
    // act
    final result = TvSeriesTable.fromEntity(testTvSeriesDetail);
    
    // assert
    expect(result, isA<TvSeriesTable>());
    expect(result.id, testTvSeriesDetail.id);
    expect(result.name, testTvSeriesDetail.name);
  });

  test('should return a table from map', () async {
    // act
    final result = TvSeriesTable.fromMap(testTvSeriesMap);
    
    // assert
    expect(result, testTvSeriesTable);
  });
}
