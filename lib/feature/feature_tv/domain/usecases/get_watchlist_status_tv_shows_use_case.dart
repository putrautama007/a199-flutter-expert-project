import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetWatchListStatusTvShowsUseCase {
  Future<bool> isAddedToWatchlist(int id);
}

class GetWatchListStatusTvShowsUseCaseImpl extends GetWatchListStatusTvShowsUseCase {
  final TvRepositories tvRepositories;

  GetWatchListStatusTvShowsUseCaseImpl({
    required this.tvRepositories,
  });

  @override
  Future<bool> isAddedToWatchlist(int id) =>
      tvRepositories.isAddedToWatchlist(id,);
}
