import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tv_series_repository.dart';

class SaveTvSeriesWatchlist {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
