import 'package:ditonton/core/util/common/exception.dart';
import 'package:ditonton/core/util/db/database_helper.dart';
import 'package:ditonton/core/data/models/watch_list_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(WatchListTable movie);
  Future<String> removeWatchlist(WatchListTable movie);
  Future<WatchListTable?> getMovieById(int id);
  Future<List<WatchListTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchListTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchListTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchListTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return WatchListTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchListTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchListTable.fromMap(data)).toList();
  }
}
