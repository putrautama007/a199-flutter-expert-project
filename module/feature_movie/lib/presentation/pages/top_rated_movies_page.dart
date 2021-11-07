import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_cubit.dart';
import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_state.dart';
import 'package:feature_movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class TopRatedMoviesPage extends StatelessWidget {
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedCubit, TopRatedState>(
          builder: (context, state) {
            if (state is TopRatedErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is TopRatedLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movieList[index];
                  return MovieCard(movie);
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
