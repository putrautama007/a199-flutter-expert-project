import 'dart:async';

import 'package:core/core.dart';
import 'package:feature_home/feature_home.dart';
import 'package:feature_movie/data/datasources/movie_local_data_source.dart';
import 'package:feature_movie/data/datasources/movie_remote_data_source.dart';
import 'package:feature_movie/data/repositories/movie_repository_impl.dart';
import 'package:feature_movie/domain/repositories/movie_repository.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:feature_movie/feature_movie.dart';
import 'package:feature_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:feature_movie/presentation/provider/movie_search_notifier.dart';
import 'package:feature_movie/presentation/provider/popular_movies_notifier.dart';
import 'package:feature_movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:feature_tv/data/repositories/tv_repositories_impl.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';
import 'package:feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:feature_tv/feature_tv.dart';
import 'package:feature_tv/presentation/provider/tv_show_detail_notfier.dart';
import 'package:feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_show_popular_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_show_search_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_show_top_rated_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_show_watchlist_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(
      ModularApp(
        module: AppModule(),
        child: const MyApp(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<ApiHelper>((injector) => ApiHelperImpl()),
        Bind.lazySingleton<DatabaseHelper>((injector) => DatabaseHelper()),
        Bind.lazySingleton<MovieRemoteDataSource>(
          (injector) => MovieRemoteDataSourceImpl(
            client: injector(),
          ),
        ),
        Bind.lazySingleton<MovieLocalDataSource>(
          (injector) => MovieLocalDataSourceImpl(
            databaseHelper: injector(),
          ),
        ),
        Bind.lazySingleton<TvRemoteDataSource>(
          (injector) => TvRemoteDataSourceImpl(
            client: injector(),
          ),
        ),
        Bind.lazySingleton<TvLocalDataSource>(
          (injector) => TvLocalDataSourceImpl(
            databaseHelper: injector(),
          ),
        ),
        Bind.lazySingleton<TvRepositories>(
          (injector) => TvRepositoriesImpl(
            tvLocalDataSource: injector(),
            tvRemoteDataSource: injector(),
          ),
        ),
        Bind.lazySingleton<MovieRepository>(
          (injector) => MovieRepositoryImpl(
            remoteDataSource: injector(),
            localDataSource: injector(),
          ),
        ),
        Bind.lazySingleton<SearchTvShowsUseCase>(
          (injector) => SearchTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<RemoveWatchListTvShowsUseCase>(
          (injector) => RemoveWatchListTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<SaveWatchListTvShowsUseCase>(
          (injector) => SaveWatchListTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetWatchListTvShowsUseCase>(
          (injector) => GetWatchListTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetWatchListStatusTvShowsUseCase>(
          (injector) => GetWatchListStatusTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetRecommendationTvShowsUseCase>(
          (injector) => GetRecommendationTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetDetailTvShowsUseCase>(
          (injector) => GetDetailTvShowUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetTopRatedTvShowsUseCase>(
          (injector) => GetTopRatedTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetPopularTvShowsUseCase>(
          (injector) => GetPopularTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton<GetNowPlayingTvShowsUseCase>(
          (injector) => GetNowPlayingTvShowsUseCaseImpl(
            tvRepositories: injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetWatchlistMovies(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => RemoveWatchlist(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => SaveWatchlist(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetWatchListStatus(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => SearchMovies(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetMovieRecommendations(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetMovieDetail(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetTopRatedMovies(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetPopularMovies(
            injector(),
          ),
        ),
        Bind.lazySingleton(
          (injector) => GetNowPlayingMovies(
            injector(),
          ),
        ),
        Bind.factory(
          (injector) => TvShowWatchListNotifier(
            getWatchListTvShowsUseCase: injector(),
          ),
        ),
        Bind.factory(
          (injector) => TvShowTopRatedNotifier(
            getTopRatedTvShowsUseCase: injector(),
          ),
        ),
        Bind.factory(
          (injector) => TvShowPopularNotifier(
            getPopularTvShowsUseCase: injector(),
          ),
        ),
        Bind.factory(
          (injector) => TvShowSearchNotifier(
            searchTvShowsUseCase: injector(),
          ),
        ),
        Bind.factory(
          (injector) => TvShowDetailNotifier(
            getDetailTvShowsUseCase: injector(),
            getRecommendationTvShowsUseCase: injector(),
            getWatchListStatusTvShowsUseCase: injector(),
            saveWatchListTvShowsUseCase: injector(),
            removeWatchListTvShowsUseCase: injector(),
          ),
        ),
        Bind.factory(
          (injector) => TvShowListNotifier(
            getNowPlayingTvShowsUseCase: injector(),
            getPopularTvShowsUseCase: injector(),
            getTopRatedTvShowsUseCase: injector(),
          ),
        ),
        Bind.factory(
          (injector) => WatchlistMovieNotifier(
            getWatchlistMovies: injector(),
          ),
        ),
        Bind.factory(
          (injector) => TopRatedMoviesNotifier(
            getTopRatedMovies: injector(),
          ),
        ),
        Bind.factory(
          (injector) => PopularMoviesNotifier(
            injector(),
          ),
        ),
        Bind.factory(
          (injector) => MovieSearchNotifier(
            searchMovies: injector(),
          ),
        ),
        Bind.factory(
          (injector) => MovieDetailNotifier(
            getMovieDetail: injector(),
            getMovieRecommendations: injector(),
            getWatchListStatus: injector(),
            saveWatchlist: injector(),
            removeWatchlist: injector(),
          ),
        ),
        Bind.factory<MovieListNotifier>(
          (injector) => MovieListNotifier(
            getNowPlayingMovies: injector(),
            getPopularMovies: injector(),
            getTopRatedMovies: injector(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          MainRoutes.home,
          module: FeatureHome(),
        ),
        ModuleRoute(
          MainRoutes.featureMovie,
          module: FeatureMovie(),
        ),
        ModuleRoute(
          MainRoutes.featureTv,
          module: FeatureTvShow(),
        ),
      ];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Modular.get<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TvShowSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TvShowPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TvShowTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Modular.get<TvShowWatchListNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        initialRoute: MainRoutes.home,
      ).modular(),
    );
  }
}
