import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';

abstract class SaveWatchListTvShowsUseCase {
  Future<Either<Failure, String>> saveWatchlist(TvDetailEntities tvShow);
}

class SaveWatchListTvShowsUseCaseImpl extends SaveWatchListTvShowsUseCase {
  final TvRepositories tvRepositories;

  SaveWatchListTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetailEntities tvShow) =>
      tvRepositories.saveWatchlist(tvShow);
}
