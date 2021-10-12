import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowTopRatedNotifier extends ChangeNotifier {
  final GetTopRatedTvShowsUseCase getTopRatedTvShowsUseCase;

  TvShowTopRatedNotifier({required this.getTopRatedTvShowsUseCase});

  RequestState state = RequestState.Empty;

  List<TvEntities> tvShow = [];

  String message = '';

  Future<void> fetchTopRatedTvShows() async {
    state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShowsUseCase.getTopRatedTvShows();

    result.fold(
      (failure) {
        message = failure.message;
        state = RequestState.Error;
        notifyListeners();
      },
      (tvEntities) {
        tvShow = tvEntities;
        state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
