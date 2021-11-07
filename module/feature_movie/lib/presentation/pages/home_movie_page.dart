import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/external/route/movie_route.dart';
import 'package:feature_movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:feature_movie/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:libraries/libraries.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatelessWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      moduleRoute: MainRoutes.featureMovie,
      searchRoute: MovieRoute.searchMovie,
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
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                final state = context.read<MovieListBloc>().state;
                if (state is MovieListLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieListNowPlayingLoadedState) {
                  return movieList(state.movieList);
                } else {
                  return const Text('Failed');
                }
              }),
              SeeMoreButton(
                title: 'Popular',
                onTap: () => Modular.to.pushNamed(
                    "${MainRoutes.featureMovie}${MovieRoute.popularMovie}"),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                    final state = context.read<MovieListBloc>().state;
                    if (state is MovieListLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieListPopularLoadedState) {
                      return movieList(state.movieList);
                    } else {
                      return const Text('Failed');
                    }
                  }),
              SeeMoreButton(
                title: 'Top Rated',
                onTap: () => Modular.to.pushNamed(
                    "${MainRoutes.featureMovie}${MovieRoute.topRatedMovie}"),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                  builder: (context, state) {
                    final state = context.read<MovieListBloc>().state;
                    if (state is MovieListLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieListTopRatedLoadedState) {
                      return movieList(state.movieList);
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

  SizedBox movieList(List<Movie> movies) => SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () => Modular.to.pushNamed(
                  "${MainRoutes.featureMovie}${MovieRoute.detailMovie}",
                  arguments: movie.id,
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
          itemCount: movies.length,
        ),
      );
}
