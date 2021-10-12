import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class SaveWatchListTvShows {
  Future<Either<Failure, String>> saveWatchlist(TvDetailEntities tvShow);
}

class SaveWatchListTvShowsImpl extends SaveWatchListTvShows {
  final TvRepositories tvRepositories;

  SaveWatchListTvShowsImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetailEntities tvShow) =>
      tvRepositories.saveWatchlist(tvShow);
}
