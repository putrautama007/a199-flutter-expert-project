import 'package:ditonton/core/data/models/watch_list_table.dart';
import 'package:ditonton/core/util/common/exception.dart';
import 'package:ditonton/core/util/db/database_helper.dart';

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
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchListTable tvShow) async {
    try {
      await databaseHelper.insertTvShowWatchlist(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchListTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return WatchListTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchListTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchListTable.fromMap(data)).toList();
  }
}
