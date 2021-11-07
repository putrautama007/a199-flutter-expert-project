import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetNowPlayingTvShowsUseCase {
  Future<Either<Failure, List<TvEntities>>> getNowPlayingTvShows();
}

class GetNowPlayingTvShowsUseCaseImpl implements GetNowPlayingTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetNowPlayingTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getNowPlayingTvShows() =>
      tvRepositories.getNowPlayingTvShows();
}
