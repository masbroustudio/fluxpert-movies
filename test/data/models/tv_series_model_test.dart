import 'dart:convert';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [18, 80],
    id: 1396,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview: 'A high school chemistry teacher.',
    popularity: 123.456,
    posterPath: '/poster.jpg',
    firstAirDate: '2008-01-20',
    name: 'Breaking Bad',
    voteAverage: 9.2,
    voteCount: 8500,
  );

  const tTvSeries = TvSeries(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [18, 80],
    id: 1396,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Breaking Bad',
    overview: 'A high school chemistry teacher.',
    popularity: 123.456,
    posterPath: '/poster.jpg',
    firstAirDate: '2008-01-20',
    name: 'Breaking Bad',
    voteAverage: 9.2,
    voteCount: 8500,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('dummy_data/tv_on_the_air.json'),
    );
    final tvSeriesMap = jsonMap['results'][0];
    
    // act
    final result = TvSeriesModel.fromJson(tvSeriesMap);
    
    // assert
    expect(result, isA<TvSeriesModel>());
  });

  test('should return a JSON map containing proper data', () async {
    // act
    final result = tTvSeriesModel.toJson();
    
    // assert
    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "genre_ids": [18, 80],
      "id": 1396,
      "origin_country": ["US"],
      "original_language": "en",
      "original_name": "Breaking Bad",
      "overview": "A high school chemistry teacher.",
      "popularity": 123.456,
      "poster_path": "/poster.jpg",
      "first_air_date": "2008-01-20",
      "name": "Breaking Bad",
      "vote_average": 9.2,
      "vote_count": 8500,
    };
    expect(result, expectedJsonMap);
  });
}
