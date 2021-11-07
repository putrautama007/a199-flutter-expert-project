import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetTopRatedTvShowsUseCase {
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvShows();
}

class GetTopRatedTvShowsUseCaseImpl implements GetTopRatedTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetTopRatedTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvShows() =>
      tvRepositories.getTopRatedTvShows();
}
