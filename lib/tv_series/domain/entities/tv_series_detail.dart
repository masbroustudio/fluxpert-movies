import 'package:ditonton/core/common/genre.dart';
import 'package:equatable/equatable.dart';

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.seasonNumber,
    this.airDate,
    this.overview,
    this.posterPath,
  });

  final int id;
  final String name;
  final int episodeCount;
  final int seasonNumber;
  final String? airDate;
  final String? overview;
  final String? posterPath;

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        seasonNumber,
        airDate,
        overview,
        posterPath,
      ];
}

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfSeasons,
        seasons,
      ];
}
