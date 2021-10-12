import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/core/presentation/widgets/button/see_more_button.dart';
import 'package:ditonton/core/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/core/util/constant/api_constants.dart';
import 'package:ditonton/core/util/style/text_styles.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/popular_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/search_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/top_rated_tv_show_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTVShowPage extends StatelessWidget {
  const HomeTVShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      searchRoute: SearchTvShowPage.routeName,
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
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return tvShowList(data.nowPlayingTvShows);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvShowPage.routeName,
                ),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return tvShowList(data.popularTvShows);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedTvShowPage.routeName,
                ),
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return tvShowList(data.topRatedTvShows);
                } else {
                  return Text('Failed');
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

  Container tvShowList(List<TvEntities> tvShows) => Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final movie = tvShows[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TvShowDetailPage.routeName,
                    arguments: movie.id.toString(),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: tvShows.length,
        ),
      );
}
