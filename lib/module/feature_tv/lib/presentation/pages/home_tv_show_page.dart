import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/external/route/tv_routes.dart';
import 'package:feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';
import 'package:provider/provider.dart';

class HomeTVShowPage extends StatelessWidget {
  const HomeTVShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      moduleRoute: MainRoutes.featureMovie,
      searchRoute: TvRoutes.tvShowSearch,
      title: 'Ditonton Tv Show',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return tvShowList(data.nowPlayingTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Modular.to.pushNamed("${MainRoutes.featureTv}${TvRoutes.tvShowPopular}"),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return tvShowList(data.popularTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Modular.to.pushNamed("${MainRoutes.featureTv}${TvRoutes.tvShowTopRated}"),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return tvShowList(data.topRatedTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubHeading({required String title, required Function() onTap}) =>
      SeeMoreButton(
        title: title,
        onTap: onTap,
      );

  SizedBox tvShowList(List<TvEntities> tvShows) => SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final movie = tvShows[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () =>Modular.to.pushNamed(
                  "${MainRoutes.featureTv}${TvRoutes.tvShowDetail}",
                  arguments: movie.id.toString(),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$baseImageUrl${movie.posterPath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: tvShows.length,
        ),
      );
}
