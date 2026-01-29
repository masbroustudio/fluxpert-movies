import 'dart:convert';
import 'package:ditonton/tv_series/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('dummy_data/tv_series_detail.json'),
    );
    
    // act
    final result = TvSeriesDetailResponse.fromJson(jsonMap);
    
    // assert
    expect(result, isA<TvSeriesDetailResponse>());
    expect(result.seasons, isNotEmpty);
  });

  test('should return a JSON map containing proper data', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('dummy_data/tv_series_detail.json'),
    );
    final response = TvSeriesDetailResponse.fromJson(jsonMap);
    
    // act
    final result = response.toJson();
    
    // assert
    expect(result, isA<Map<String, dynamic>>());
    expect(result['seasons'], isA<List>());
  });

  test('should convert to entity correctly', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('dummy_data/tv_series_detail.json'),
    );
    final response = TvSeriesDetailResponse.fromJson(jsonMap);
    
    // act
    final result = response.toEntity();
    
    // assert
    expect(result.id, response.id);
    expect(result.name, response.name);
    expect(result.seasons.length, response.seasons.length);
  });
}
