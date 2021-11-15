import 'package:feature_tv/presentation/bloc/watch_list_tv_show/watch_list_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/watch_list_tv_show/watch_list_tv_show_state.dart';
import 'package:feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class TvShowWatchListPage extends StatelessWidget {

  const TvShowWatchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  BlocBuilder<WatchListTvShowCubit, WatchListTvShowState>(
          builder: (context, state) {
            if (state is WatchListTvShowErrorState) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is WatchListTvShowLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvShowCard(tvEntities: state.tvShowList[index],);
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
