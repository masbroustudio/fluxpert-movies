import 'package:dartz/dartz.dart';
import 'package:ditonton/movie/domain/entities/movie.dart';
import 'package:ditonton/movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/core/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
