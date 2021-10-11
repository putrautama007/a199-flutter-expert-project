import 'package:ditonton/core/util/db/database_helper.dart';
import 'package:ditonton/feature/feature_movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/feature/feature_movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/feature/feature_movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/feature/feature_movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/feature/feature_movie/domain/usecases/search_movies.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/feature/feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  /// Repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /// Data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  /// Data source tv show
  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
