import 'package:ditonton/core/util/color/app_colors.dart';
import 'package:ditonton/feature/feature_home/presentation/pages/watch_list_page.dart';
import 'package:ditonton/feature/feature_home/presentation/provider/bottom_nav_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/about_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/home_movie_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/home_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());

    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
          ..fetchWatchlistMovies());

    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchNowPlayingTvShows()
          ..fetchPopulargTvShows()
          ..fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavNotifier>(
      builder: (context, bottomNavNotifier, widget) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: IndexedStack(
              index: bottomNavNotifier.tabIndex,
              children: [
                HomeMoviePage(),
                HomeTVShowPage(),
                WatchListPage(),
                AboutPage(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedItemColor: kWhite,
              unselectedItemColor: kDavysGrey,
              onTap: bottomNavNotifier.changeTabIndex,
              currentIndex: bottomNavNotifier.tabIndex,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: "Movies",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: "Tv Shows",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.save_alt),
                  label: "Watchlist",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: "About",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
