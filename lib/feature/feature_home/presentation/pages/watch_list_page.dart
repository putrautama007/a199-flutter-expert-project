import 'package:ditonton/core/util/color/app_colors.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/tv_show_watch_list_page.dart';
import 'package:flutter/material.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
            labelColor: kWhite,
            labelPadding: const EdgeInsets.only(top: 10.0),
            unselectedLabelColor: kDavysGrey,
            tabs: const [
              Tab(
                text: 'Movie',
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
              Tab(
                text: 'Tv Show',
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            TvShowWatchListPage(),
          ],
        ),
      ),
    );
  }
}
