import 'package:ditonton/movie/data/models/movie_table.dart';
import 'package:ditonton/tv_series/data/models/tv_series_table.dart';
import 'package:ditonton/core/common/genre.dart';
import 'package:ditonton/movie/domain/entities/movie.dart';
import 'package:ditonton/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testMovieCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

// TV Series Test Data
const testTvSeries = TvSeries(
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

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: '/backdrop.jpg',
  genres: [Genre(id: 18, name: 'Drama')],
  id: 1396,
  originalName: 'Breaking Bad',
  overview: 'A high school chemistry teacher.',
  posterPath: '/poster.jpg',
  firstAirDate: '2008-01-20',
  name: 'Breaking Bad',
  voteAverage: 9.2,
  voteCount: 8500,
  numberOfEpisodes: 62,
  numberOfSeasons: 5,
  seasons: [
    Season(
      id: 1,
      name: 'Season 1',
      episodeCount: 7,
      seasonNumber: 1,
      airDate: '2008-01-20',
      overview: 'Season 1 overview',
      posterPath: '/season1.jpg',
    )
  ],
);

const testTvSeriesTable = TvSeriesTable(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/poster.jpg',
  overview: 'A high school chemistry teacher.',
);

final testTvSeriesMap = {
  'id': 1396,
  'name': 'Breaking Bad',
  'posterPath': '/poster.jpg',
  'overview': 'A high school chemistry teacher.',
};

const testWatchlistTvSeries = TvSeries.watchlist(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/poster.jpg',
  overview: 'A high school chemistry teacher.',
);
