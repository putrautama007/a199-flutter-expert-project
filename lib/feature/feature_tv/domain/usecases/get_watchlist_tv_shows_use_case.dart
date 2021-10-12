import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetWatchListTvShowsUseCase {
  Future<Either<Failure, List<TvEntities>>> getWatchlistTvShows();
}

class GetWatchListTvShowsUseCaseImpl extends GetWatchListTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetWatchListTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getWatchlistTvShows() =>
      tvRepositories.getWatchlistTvShows();
}
