import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_watchlist_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowWatchListPage extends StatefulWidget {
  static const routeName = '/watchListTvShow';

  const TvShowWatchListPage({Key? key}) : super(key: key);

  @override
  _TvShowWatchListPageState createState() => _TvShowWatchListPageState();
}

class _TvShowWatchListPageState extends State<TvShowWatchListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowWatchListNotifier>(context, listen: false)
            .fetchWatchlistTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowWatchListNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvEntities = data.watchlistTvShows[index];
                  return TvShowCard(
                    tvEntities: tvEntities,
                  );
                },
                itemCount: data.watchlistTvShows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
