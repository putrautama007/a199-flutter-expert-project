import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class SearchTvShowsUseCase {
  Future<Either<Failure, List<TvEntities>>> searchTvShows(String query);
}

class SearchTvShowsUseCaseImpl extends SearchTvShowsUseCase {
  final TvRepositories tvRepositories;

  SearchTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> searchTvShows(String query) =>
      tvRepositories.searchTvShows(query);
}
