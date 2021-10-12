import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShowsUseCase searchTvShowsUseCase;

  TvShowSearchNotifier({required this.searchTvShowsUseCase});

  RequestState state = RequestState.Empty;

  List<TvEntities> searchResult = [];

  String message = '';

  Future<void> fetchTvShowSearch(String query) async {
    state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShowsUseCase.searchTvShows(query);
    result.fold(
      (failure) {
        message = failure.message;
        state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        searchResult = data;
        state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
