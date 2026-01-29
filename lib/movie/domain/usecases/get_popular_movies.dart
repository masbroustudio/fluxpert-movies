import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/movie/domain/entities/movie.dart';
import 'package:ditonton/movie/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
