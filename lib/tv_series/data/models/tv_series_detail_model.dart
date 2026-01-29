import 'package:ditonton/core/common/genre_model.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  const SeasonModel({
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

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        episodeCount: json["episode_count"],
        seasonNumber: json["season_number"],
        airDate: json["air_date"],
        overview: json["overview"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "episode_count": episodeCount,
        "season_number": seasonNumber,
        "air_date": airDate,
        "overview": overview,
        "poster_path": posterPath,
      };

  Season toEntity() {
    return Season(
      id: id,
      name: name,
      episodeCount: episodeCount,
      seasonNumber: seasonNumber,
      airDate: airDate,
      overview: overview,
      posterPath: posterPath,
    );
  }

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

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
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
  final List<GenreModel> genres;
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
  final List<SeasonModel> seasons;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      seasons: seasons.map((season) => season.toEntity()).toList(),
    );
  }

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
