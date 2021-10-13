import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowWatchListNotifier extends ChangeNotifier {
  var watchlistMovies = <TvEntities>[];

  var watchlistState = RequestState.Empty;

  String message = '';

  TvShowWatchListNotifier({required this.getWatchListTvShowsUseCase});

  final GetWatchListTvShowsUseCase getWatchListTvShowsUseCase;

  Future<void> fetchWatchlistTvShows() async {
    watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTvShowsUseCase.getWatchlistTvShows();
    result.fold(
      (failure) {
        watchlistState = RequestState.Error;
        message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        watchlistState = RequestState.Loaded;
        watchlistMovies = tvShowData;
        notifyListeners();
      },
    );
  }
}
