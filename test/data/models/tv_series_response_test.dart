import 'dart:convert';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('dummy_data/tv_on_the_air.json'),
    );
    
    // act
    final result = TvSeriesResponse.fromJson(jsonMap);
    
    // assert
    expect(result, isA<TvSeriesResponse>());
    expect(result.tvSeriesList, isNotEmpty);
  });

  test('should return a JSON map containing proper data', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('dummy_data/tv_on_the_air.json'),
    );
    final response = TvSeriesResponse.fromJson(jsonMap);
    
    // act
    final result = response.toJson();
    
    // assert
    expect(result, isA<Map<String, dynamic>>());
    expect(result['results'], isA<List>());
  });
}
