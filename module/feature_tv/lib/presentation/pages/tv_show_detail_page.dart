import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/external/route/tv_routes.dart';
import 'package:feature_tv/presentation/bloc/detail_tv_show/detail_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/detail_tv_show/detail_tv_show_state.dart';
import 'package:feature_tv/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_cubit.dart';
import 'package:feature_tv/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_state.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_show/recommendation_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_show/recommendation_tv_show_state.dart';
import 'package:feature_tv/presentation/bloc/watch_list_tv_show/watch_list_tv_show_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libraries/libraries.dart';

class TvShowDetailPage extends StatelessWidget {
  final String tvId;

  const TvShowDetailPage({required this.tvId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTVShowCubit, DetailTvShowState>(
        builder: (context, state) {
          if (state is DetailTvShowErrorState) {
            return Text(state.message);
          } else if (state is DetailTvShowLoadedState) {
            return SafeArea(
              child: DetailContent(
                state.tvDetailEntities,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetailEntities tvShow;

  const DetailContent(this.tvShow, {Key? key}) : super(key: key);

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
                            BlocBuilder<IsTvShowAddWatchlistCubit,
                                IsTvShowAddWatchListState>(builder: (context, state) {
                              if (state is IsTvShowAddWatchListAddTvShowState) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    BlocProvider.of<IsTvShowAddWatchlistCubit>(
                                        context)
                                        .addWatchlist(tvShow);
                                    BlocProvider.of<WatchListTvShowCubit>(
                                        context)
                                        .fetchWatchlistTvShow();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              } else if (state
                              is IsTvShowAddWatchListRemoveTvShowState) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    BlocProvider.of<IsTvShowAddWatchlistCubit>(
                                        context)
                                        .removeFromWatchlist(tvShow);
                                    BlocProvider.of<WatchListTvShowCubit>(
                                        context)
                                        .fetchWatchlistTvShow();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.check),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
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
                            ), BlocBuilder<RecommendationTvShowCubit,
                                RecommendationTvShowState>(
                              builder: (context, state) {
                                if (state is RecommendationTvShowLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                is RecommendationTvShowErrorState) {
                                  return Text(state.message);
                                } else if (state
                                is RecommendationTvShowLoadedState) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = state.tvShowList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () =>
                                                Modular.to.pushReplacementNamed(
                                                  "${MainRoutes.featureTv}${TvRoutes.tvShowDetail}",
                                                  arguments: tvShow.id.toString(),
                                                ),
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
                                      itemCount: state.tvShowList.length,
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
