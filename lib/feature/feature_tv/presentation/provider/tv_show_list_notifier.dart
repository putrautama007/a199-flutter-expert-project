import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowListNotifier extends ChangeNotifier {
  List<TvEntities> nowPlayingTvShows = <TvEntities>[];

  RequestState nowPlayingState = RequestState.empty;

  List<TvEntities> popularTvShows = <TvEntities>[];

  RequestState popularState = RequestState.empty;

  List<TvEntities> topRatedTvShows = <TvEntities>[];

  RequestState topRatedState = RequestState.empty;

  String message = '';

  TvShowListNotifier({
    required this.getNowPlayingTvShowsUseCase,
    required this.getPopularTvShowsUseCase,
    required this.getTopRatedTvShowsUseCase,
  });

  final GetNowPlayingTvShowsUseCase getNowPlayingTvShowsUseCase;
  final GetPopularTvShowsUseCase getPopularTvShowsUseCase;
  final GetTopRatedTvShowsUseCase getTopRatedTvShowsUseCase;

  Future<void> fetchNowPlayingTvShows() async {
    nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvShowsUseCase.getNowPlayingTvShows();
    result.fold(
      (failure) {
        nowPlayingState = RequestState.error;
        message = failure.message;
        notifyListeners();
      },
      (List<TvEntities> tvEntities) {
        nowPlayingState = RequestState.loaded;
        nowPlayingTvShows = tvEntities;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopulargTvShows() async {
    popularState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShowsUseCase.getPopularTvShows();
    result.fold(
      (failure) {
        popularState = RequestState.error;
        message = failure.message;
        notifyListeners();
      },
      (List<TvEntities> tvEntities) {
        popularState = RequestState.loaded;
        popularTvShows = tvEntities;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    topRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShowsUseCase.getTopRatedTvShows();
    result.fold(
      (failure) {
        topRatedState = RequestState.error;
        message = failure.message;
        notifyListeners();
      },
      (List<TvEntities> tvEntities) {
        topRatedState = RequestState.loaded;
        topRatedTvShows = tvEntities;
        notifyListeners();
      },
    );
  }
}
