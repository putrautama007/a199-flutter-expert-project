import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

abstract class GetWatchListStatusTvShows {
  Future<bool> isAddedToWatchlist(int id);
}

class GetWatchListStatusTvShowsImpl extends GetWatchListStatusTvShows {
  final TvRepositories tvRepositories;

  GetWatchListStatusTvShowsImpl({
    required this.tvRepositories,
  });

  @override
  Future<bool> isAddedToWatchlist(int id) =>
      tvRepositories.isAddedToWatchlist(id,);
}
