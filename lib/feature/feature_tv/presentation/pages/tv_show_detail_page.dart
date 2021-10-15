import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/core/domain/entities/genre.dart';
import 'package:ditonton/core/util/color/app_colors.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/core/util/constant/watch_list_constants.dart';
import 'package:ditonton/core/util/style/text_styles.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_detail_notfier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvShowDetailPage extends StatefulWidget {
  static const routeName = '/tvShowDetailPage';

  final String tvId;

  const TvShowDetailPage({required this.tvId, Key? key}) : super(key: key);

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvShowDetailNotifier>(context, listen: false)
        ..fetchTvShowDetail(widget.tvId)
        ..loadWatchlistStatus(int.parse(widget.tvId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvShowState == RequestState.loaded) {
            final tvShow = provider.tvShow;
            return SafeArea(
              child: DetailContent(
                tvShow,
                provider.tvShowRecommendations,
                provider.isAddedtoWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetailEntities tvShow;
  final List<TvEntities> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.tvShow, this.recommendations, this.isAddedWatchlist,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShow.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvShowDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(tvShow);
                                } else {
                                  await Provider.of<TvShowDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(tvShow);
                                }

                                final message =
                                    Provider.of<TvShowDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        WatchListConstants
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        WatchListConstants
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvShow.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Episode',
                              style: kHeading6,
                            ),
                            Text(
                              'Number of Episode : ${tvShow.numberOfEpisodes}',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Last Episode : ${tvShow.lastEpisodeToAir.episodeNumber}',
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 150,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${tvShow.lastEpisodeToAir.stillPath}',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvShowSeasons = tvShow.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500${tvShowSeasons.posterPath}',
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: tvShow.seasons.length,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvShowDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.routeName,
                                                arguments: tvShow.id.toString(),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
