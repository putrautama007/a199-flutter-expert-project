import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:flutter/material.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  final GetDetailTvShowsUseCase getDetailTvShowsUseCase;
  final GetRecommendationTvShowsUseCase getRecommendationTvShowsUseCase;
  final GetWatchListStatusTvShowsUseCase getWatchListStatusTvShowsUseCase;
  final SaveWatchListTvShowsUseCase saveWatchListTvShowsUseCase;
  final RemoveWatchListTvShowsUseCase removeWatchListTvShowsUseCase;

  TvShowDetailNotifier({
    required this.getDetailTvShowsUseCase,
    required this.getRecommendationTvShowsUseCase,
    required this.getWatchListStatusTvShowsUseCase,
    required this.saveWatchListTvShowsUseCase,
    required this.removeWatchListTvShowsUseCase,
  });

  late TvDetailEntities tvShow;

  RequestState tvShowState = RequestState.empty;

  List<TvEntities> tvShowRecommendations = [];

  RequestState recommendationState = RequestState.empty;

  String message = '';

  bool isAddedtoWatchlist = false;

  Future<void> fetchTvShowDetail(String tvId) async {
    tvShowState = RequestState.loading;
    notifyListeners();
    final detailResult =
        await getDetailTvShowsUseCase.getDetailTvShows(tvId: tvId);
    final recommendationResult = await getRecommendationTvShowsUseCase
        .getRecommendationTvShows(tvId: tvId);
    detailResult.fold(
      (failure) {
        tvShowState = RequestState.error;
        message = failure.message;
        notifyListeners();
      },
      (tvShowDetail) {
        recommendationState = RequestState.loading;
        tvShow = tvShowDetail;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            recommendationState = RequestState.error;
            message = failure.message;
          },
          (tvShowRecommendationList) {
            recommendationState = RequestState.loaded;
            tvShowRecommendations = tvShowRecommendationList;
          },
        );
        tvShowState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String watchlistMessage = '';

  Future<void> addWatchlist(TvDetailEntities tvShow) async {
    final result = await saveWatchListTvShowsUseCase.saveWatchlist(tvShow);

    await result.fold(
      (failure) async {
        watchlistMessage = failure.message;
      },
      (successMessage) async {
        watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvDetailEntities tvShow) async {
    final result = await removeWatchListTvShowsUseCase.removeWatchlist(tvShow);

    await result.fold(
      (failure) async {
        watchlistMessage = failure.message;
      },
      (successMessage) async {
        watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result =
        await getWatchListStatusTvShowsUseCase.isAddedToWatchlist(id);
    isAddedtoWatchlist = result;
    notifyListeners();
  }
}
