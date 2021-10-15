import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowTopRatedNotifier extends ChangeNotifier {
  final GetTopRatedTvShowsUseCase getTopRatedTvShowsUseCase;

  TvShowTopRatedNotifier({required this.getTopRatedTvShowsUseCase});

  RequestState state = RequestState.empty;

  List<TvEntities> tvShow = [];

  String message = '';

  Future<void> fetchTopRatedTvShows() async {
    state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShowsUseCase.getTopRatedTvShows();

    result.fold(
      (failure) {
        message = failure.message;
        state = RequestState.error;
        notifyListeners();
      },
      (tvEntities) {
        tvShow = tvEntities;
        state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
