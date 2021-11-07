import 'package:core/core.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(WatchListTable tvShow);

  Future<String> removeWatchlist(WatchListTable tvShow);

  Future<WatchListTable?> getTvShowById(int id);

  Future<List<WatchListTable>> getWatchlistTvShows();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchListTable tvShow) async {
    try {
      await databaseHelper.insertTvShowWatchlist(tvShow);
      return WatchListConstants.watchlistAddSuccessMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchListTable tvShow) async {
    try {
      await databaseHelper.removeTvShowWatchlist(tvShow);
      return WatchListConstants.watchlistRemoveSuccessMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchListTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return WatchListTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchListTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => WatchListTable.fromMap(data)).toList();
  }
}
