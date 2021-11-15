import 'package:feature_tv/presentation/bloc/popular_tv_show/popular_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_show/popular_tv_show_state.dart';
import 'package:feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class PopularTvShowPage extends StatelessWidget {
  const PopularTvShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowCubit, PopularTvShowState>(
          builder: (context, state) {
            if (state is PopularTvShowErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is PopularTvShowLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShowList[index];
                  return TvShowCard(tvEntities: tvShow);
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
