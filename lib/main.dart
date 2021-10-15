import 'package:ditonton/core/util/color/app_colors.dart';
import 'package:ditonton/core/util/theme/app_theme.dart';
import 'package:ditonton/feature/feature_home/presentation/pages/bottom_nav_page.dart';
import 'package:ditonton/feature/feature_home/presentation/provider/bottom_nav_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/about_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/search_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/popular_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/search_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/top_rated_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/tv_show_watch_list_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_detail_notfier.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_popular_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_search_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_top_rated_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/core/util/di/injection.dart' as di;

import 'feature/feature_tv/presentation/provider/tv_show_watchlist_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<BottomNavNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowWatchListNotifier>(),
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
        home: BottomNavPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => BottomNavPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvShowDetailPage.routeName:
              final tvId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(tvId: tvId),
                settings: settings,
              );
            case SearchTvShowPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchTvShowPage());
            case PopularTvShowPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularTvShowPage());
            case TopRatedTvShowPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowPage());
            case TvShowWatchListPage.routeName:
              return MaterialPageRoute(builder: (_) => TvShowWatchListPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
