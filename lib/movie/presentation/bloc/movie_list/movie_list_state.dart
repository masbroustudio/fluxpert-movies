import 'package:equatable/equatable.dart';
import 'package:ditonton/movie/domain/entities/movie.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;

  const MovieListLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieListError extends MovieListState {
  final String message;

  const MovieListError(this.message);

  @override
  List<Object?> get props => [message];
}
