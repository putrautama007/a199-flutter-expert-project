import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowWatchListNotifier extends ChangeNotifier {
  var watchlistTvShows = <TvEntities>[];

  var watchlistState = RequestState.empty;

  String message = '';

  TvShowWatchListNotifier({required this.getWatchListTvShowsUseCase});

  final GetWatchListTvShowsUseCase getWatchListTvShowsUseCase;

  Future<void> fetchWatchlistTvShows() async {
    watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchListTvShowsUseCase.getWatchlistTvShows();
    result.fold(
      (failure) {
        watchlistState = RequestState.error;
        message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        watchlistState = RequestState.loaded;
        watchlistTvShows = tvShowData;
        notifyListeners();
      },
    );
  }
}
