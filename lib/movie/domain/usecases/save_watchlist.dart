import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/movie/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
