import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';

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
