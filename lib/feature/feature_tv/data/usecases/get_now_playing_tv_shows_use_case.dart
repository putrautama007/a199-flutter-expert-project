import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

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
