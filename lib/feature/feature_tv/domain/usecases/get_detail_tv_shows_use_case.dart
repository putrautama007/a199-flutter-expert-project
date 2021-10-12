import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetDetailTvShowsUseCase {
  Future<Either<Failure, TvDetailEntities>> getDetailTvShows({
    required String tvId,
  });
}

class GetDetailTvShowUseCaseImpl extends GetDetailTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetDetailTvShowUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, TvDetailEntities>> getDetailTvShows(
          {required String tvId}) =>
      tvRepositories.getDetailTvShows(
        tvId: tvId,
      );
}
