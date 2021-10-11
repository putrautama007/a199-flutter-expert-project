import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetPopularTvShowsUseCase {
  Future<Either<Failure, List<TvEntities>>> getPopularTvShows();
}

class GetPopularTvShowsUseCaseImpl implements GetPopularTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetPopularTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getPopularTvShows() =>
      tvRepositories.getPopularTvShows();
}
