import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_top_rated_notifier.dart';
import 'package:ditonton/feature/feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvShowPage extends StatefulWidget {
  static const routeName = '/topRatedTvShow';

  const TopRatedTvShowPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowPageState createState() => _TopRatedTvShowPageState();
}

class _TopRatedTvShowPageState extends State<TopRatedTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowTopRatedNotifier>(context, listen: false)
            .fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowTopRatedNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShow[index];
                  return TvShowCard(
                    tvEntities: tvShow,
                  );
                },
                itemCount: data.tvShow.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
