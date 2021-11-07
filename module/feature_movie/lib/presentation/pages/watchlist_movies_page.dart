import 'package:feature_movie/presentation/bloc/watch_list/watch_list_movie_cubit.dart';
import 'package:feature_movie/presentation/bloc/watch_list/watch_list_movie_state.dart';
import 'package:feature_movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class WatchlistMoviesPage extends StatelessWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListMovieCubit, WatchListMovieState>(
          builder: (context, state) {
            if (state is WatchListErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is WatchListLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCard(state.movieList[index]);
                },
                itemCount: state.movieList.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
