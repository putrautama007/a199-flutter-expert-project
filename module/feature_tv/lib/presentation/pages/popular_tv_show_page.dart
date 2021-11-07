import 'package:core/core.dart';
import 'package:feature_tv/presentation/provider/tv_show_popular_notifier.dart';
import 'package:feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvShowPage extends StatefulWidget {

  const PopularTvShowPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowPageState createState() => _PopularTvShowPageState();
}

class _PopularTvShowPageState extends State<PopularTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowPopularNotifier>(context, listen: false)
            .fetchPopularTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowPopularNotifier>(
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