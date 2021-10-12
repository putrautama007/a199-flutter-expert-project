import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetRecommendationTvShowsUseCase {
  Future<Either<Failure, List<TvEntities>>> getRecommendationTvShows({
    required String tvId,
  });
}

class GetRecommendationTvShowsUseCaseImpl
    extends GetRecommendationTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetRecommendationTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getRecommendationTvShows(
          {required String tvId}) =>
      tvRepositories.getRecommendationTvShows(
        tvId: tvId,
      );
}
