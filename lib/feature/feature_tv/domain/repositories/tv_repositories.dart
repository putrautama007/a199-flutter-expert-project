import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';

abstract class TvRepositories {
  Future<Either<Failure, List<TvEntities>>> getNowPlayingTvShows();

  Future<Either<Failure, List<TvEntities>>> getPopularTvShows();

  Future<Either<Failure, List<TvEntities>>> getTopRatedTvShows();

  Future<Either<Failure, TvDetailEntities>> getDetailTvShows({
    required String tvId,
  });

  Future<Either<Failure, List<TvEntities>>> getRecommendationTvShows({
    required String tvId,
  });

  Future<Either<Failure, String>> saveWatchlist(TvDetailEntities tvShow);
  Future<Either<Failure, String>> removeWatchlist(TvDetailEntities tvShow);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvEntities>>> getWatchlistTvShows();
}
