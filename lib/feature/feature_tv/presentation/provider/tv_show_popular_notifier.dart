import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowPopularNotifier extends ChangeNotifier {
  final GetPopularTvShowsUseCase getPopularTvShowsUseCase;

  TvShowPopularNotifier(this.getPopularTvShowsUseCase);

  RequestState state = RequestState.Empty;

  List<TvEntities> tvShow = [];

  String message = '';

  Future<void> fetchPopularTvShows() async {
    state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShowsUseCase.getPopularTvShows();

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
