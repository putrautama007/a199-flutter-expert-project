import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/core/presentation/widgets/button/see_more_button.dart';
import 'package:ditonton/core/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/core/util/constant/api_constants.dart';
import 'package:ditonton/core/util/style/text_styles.dart';
import 'package:ditonton/feature/feature_movie/domain/entities/movie.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/search_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/feature/feature_movie/presentation/provider/movie_list_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      searchRoute: SearchPage.ROUTE_NAME,
      title: 'Ditonton Movie',
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
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return movieList(data.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              }),
              SeeMoreButton(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return movieList(data.popularMovies);
                } else {
                  return Text('Failed');
                }
              }),
              SeeMoreButton(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return movieList(data.topRatedMovies);
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


  Container movieList(List<Movie> movies) =>
      Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.ROUTE_NAME,
                    arguments: movie.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                    placeholder: (context, url) =>
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: movies.length,
        ),
      );
}
