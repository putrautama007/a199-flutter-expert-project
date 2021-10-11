import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';

abstract class TvRepositories{
  Future<Either<Failure, List<TvEntities>>> getNowPlayingTvShows();
  Future<Either<Failure, List<TvEntities>>> getPopularTvShows();
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvShows();
}