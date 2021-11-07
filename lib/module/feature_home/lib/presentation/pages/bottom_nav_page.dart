import 'package:core/core.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_event.dart';
import 'package:feature_home/presentation/pages/watch_list_page.dart';
import 'package:feature_movie/presentation/pages/about_page.dart';
import 'package:feature_movie/presentation/pages/home_movie_page.dart';
import 'package:feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:feature_movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:feature_tv/presentation/pages/home_tv_show_page.dart';
import 'package:feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_show_watchlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

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

    Future.microtask(() =>
    Provider.of<TvShowWatchListNotifier>(context, listen: false)
      ..fetchWatchlistTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, int>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: IndexedStack(
              index: BlocProvider.of<BottomNavBloc>(context).state,
              children: const [
                HomeMoviePage(),
                HomeTVShowPage(),
                WatchListPage(),
                AboutPage(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
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
              onTap: (value){
                BlocProvider.of<BottomNavBloc>(context).add(ChangeTabEvent(state: value));
              },
              currentIndex: BlocProvider.of<BottomNavBloc>(context).state,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
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
