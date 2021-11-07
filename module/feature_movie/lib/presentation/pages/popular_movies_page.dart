import 'package:feature_movie/presentation/bloc/popular_movie/popular_cubit.dart';
import 'package:feature_movie/presentation/bloc/popular_movie/popular_state.dart';
import 'package:feature_movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularCubit, PopularState>(
          builder: (context, state) {
            if (state is PopularErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is PopularLoadedState) {
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
