import 'package:ditonton/core/util/db/database_helper.dart';
import 'package:ditonton/feature/feature_home/presentation/provider/bottom_nav_notifier.dart';
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
import 'package:ditonton/feature/feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/feature/feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/feature/feature_tv/data/repositories/tv_repositories_impl.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  /// Provider bottom nav
  locator.registerFactory(
    () => BottomNavNotifier(),
  );

  /// Provider movie
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

  /// Provider tv show
  locator.registerFactory(
    () => TvShowListNotifier(
      getNowPlayingTvShowsUseCase: locator(),
      getPopularTvShowsUseCase: locator(),
      getTopRatedTvShowsUseCase: locator(),
    ),
  );

  /// Use case movie
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

  /// Use case tv show
  locator.registerLazySingleton<GetNowPlayingTvShowsUseCase>(
    () => GetNowPlayingTvShowsUseCaseImpl(
      tvRepositories: locator(),
    ),
  );
  locator.registerLazySingleton<GetPopularTvShowsUseCase>(
    () => GetPopularTvShowsUseCaseImpl(
      tvRepositories: locator(),
    ),
  );
  locator.registerLazySingleton<GetTopRatedTvShowsUseCase>(
    () => GetTopRatedTvShowsUseCaseImpl(
      tvRepositories: locator(),
    ),
  );

  locator.registerLazySingleton<GetDetailTvShowsUseCase>(
    () => GetDetailTvShowUseCaseImpl(
      tvRepositories: locator(),
    ),
  );

  locator.registerLazySingleton<GetRecommendationTvShowsUseCase>(
    () => GetRecommendationTvShowsUseCaseImpl(
      tvRepositories: locator(),
    ),
  );

  /// Repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /// Repository tv show
  locator.registerLazySingleton<TvRepositories>(
    () => TvRepositoriesImpl(
      tvRemoteDataSource: locator(),
      tvLocalDataSource: locator(),
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
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
