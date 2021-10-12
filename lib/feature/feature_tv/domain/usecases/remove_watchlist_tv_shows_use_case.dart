import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class RemoveWatchListTvShowsUseCase {
  Future<Either<Failure, String>> removeWatchlist(TvDetailEntities tvShow);
}

class RemoveWatchListTvShowsUseCaseImpl extends RemoveWatchListTvShowsUseCase {
  final TvRepositories tvRepositories;

  RemoveWatchListTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetailEntities tvShow) =>
      tvRepositories.removeWatchlist(tvShow);
}
