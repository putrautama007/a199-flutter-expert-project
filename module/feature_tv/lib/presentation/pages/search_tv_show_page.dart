import 'package:core/core.dart';
import 'package:feature_tv/presentation/bloc/search_tv_show/search_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/search_tv_show/search_tv_show_state.dart';
import 'package:feature_tv/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class SearchTvShowPage extends StatelessWidget {
  const SearchTvShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                BlocProvider.of<SearchTvShowCubit>(context)
                    .fetchTvShowSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvShowCubit, SearchTvShowState>(
              builder: (context, state) {
                if (state is SearchTvShowLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvShowLoadedState) {
                  final result = state.tvShowList;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return TvShowCard(tvEntities: result[index]);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
