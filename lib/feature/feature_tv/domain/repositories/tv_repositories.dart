import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/data/models/tv_model.dart';

abstract class TvRepositories{
  Future<Either<Failure, List<TvModel>>> getNowPlayingTvShows();
  Future<Either<Failure, List<TvModel>>> getPopularTvShows();
  Future<Either<Failure, List<TvModel>>> getTopRatedTvShows();
}