import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShowsUseCase searchTvShowsUseCase;

  TvShowSearchNotifier({required this.searchTvShowsUseCase});

  RequestState state = RequestState.empty;

  List<TvEntities> searchResult = [];

  String message = '';

  Future<void> fetchTvShowSearch(String query) async {
    state = RequestState.loading;
    notifyListeners();

    final result = await searchTvShowsUseCase.searchTvShows(query);
    result.fold(
      (failure) {
        message = failure.message;
        state = RequestState.error;
        notifyListeners();
      },
      (data) {
        searchResult = data;
        state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
