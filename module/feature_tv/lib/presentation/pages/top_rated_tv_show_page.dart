import 'package:feature_tv/presentation/bloc/top_rated_tv_show/top_rated_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_show/top_rated_tv_show_state.dart';
import 'package:feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class TopRatedTvShowPage extends StatelessWidget {
  const TopRatedTvShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowCubit, TopRatedTvShowState>(
          builder: (context, state) {
            if (state is TopRatedTvShowErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is TopRatedTvShowLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShowList[index];
                  return TvShowCard(
                    tvEntities: tvShow,
                  );
                },
                itemCount: state.tvShowList.length,
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
