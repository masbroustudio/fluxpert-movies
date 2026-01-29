import 'package:equatable/equatable.dart';
import 'package:ditonton/movie/domain/entities/movie.dart';
import 'package:ditonton/movie/domain/entities/movie_detail.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  const MovieDetailLoaded(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

// Recommendations States
abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationsEmpty extends MovieRecommendationsState {}

class MovieRecommendationsLoading extends MovieRecommendationsState {}

class MovieRecommendationsLoaded extends MovieRecommendationsState {
  final List<Movie> movies;

  const MovieRecommendationsLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  const MovieRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Watchlist States
class WatchlistStatus extends Equatable {
  final bool isAddedToWatchlist;

  const WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class WatchlistMessage extends Equatable {
  final String message;

  const WatchlistMessage(this.message);

  @override
  List<Object?> get props => [message];
}
