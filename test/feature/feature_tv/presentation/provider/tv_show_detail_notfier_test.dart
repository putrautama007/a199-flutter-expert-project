import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_detail_notfier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/dummy_data/dummy_objects.dart';
import 'tv_show_detail_notfier_test.mocks.dart';

@GenerateMocks([
  GetDetailTvShowsUseCase,
  GetRecommendationTvShowsUseCase,
  GetWatchListStatusTvShowsUseCase,
  SaveWatchListTvShowsUseCase,
  RemoveWatchListTvShowsUseCase,
])
void main() {
  late TvShowDetailNotifier tvShowDetailNotifier;
  late MockGetDetailTvShowsUseCase mockGetDetailTvShowsUseCase;
  late MockGetRecommendationTvShowsUseCase mockGetRecommendationTvShowsUseCase;
  late MockGetWatchListStatusTvShowsUseCase
      mockGetWatchListStatusTvShowsUseCase;
  late MockSaveWatchListTvShowsUseCase mockSaveWatchListTvShowsUseCase;
  late MockRemoveWatchListTvShowsUseCase mockRemoveWatchListTvShowsUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailTvShowsUseCase = MockGetDetailTvShowsUseCase();
    mockGetRecommendationTvShowsUseCase = MockGetRecommendationTvShowsUseCase();
    mockGetWatchListStatusTvShowsUseCase =
        MockGetWatchListStatusTvShowsUseCase();
    mockSaveWatchListTvShowsUseCase = MockSaveWatchListTvShowsUseCase();
    mockRemoveWatchListTvShowsUseCase = MockRemoveWatchListTvShowsUseCase();
    tvShowDetailNotifier = TvShowDetailNotifier(
      getDetailTvShowsUseCase: mockGetDetailTvShowsUseCase,
      getRecommendationTvShowsUseCase: mockGetRecommendationTvShowsUseCase,
      getWatchListStatusTvShowsUseCase: mockGetWatchListStatusTvShowsUseCase,
      saveWatchListTvShowsUseCase: mockSaveWatchListTvShowsUseCase,
      removeWatchListTvShowsUseCase: mockRemoveWatchListTvShowsUseCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tvId = "1";

  void _arrangeUseCase() {
    when(mockGetDetailTvShowsUseCase.getDetailTvShows(tvId: tvId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
            tvId: tvId))
        .thenAnswer((_) async => Right(testTvShowList));
  }

  group('Get Tv Show Detail', () {
    test('should get data from the use case', () async {
      /// arrange
      _arrangeUseCase();

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      verify(mockGetDetailTvShowsUseCase.getDetailTvShows(tvId: tvId));
      verify(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
          tvId: tvId));
    });

    test('should change state to Loading when use case is called', () {
      /// arrange
      _arrangeUseCase();

      /// act
      tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      expect(tvShowDetailNotifier.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      /// arrange
      _arrangeUseCase();

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      expect(tvShowDetailNotifier.tvShowState, RequestState.Loaded);
      expect(tvShowDetailNotifier.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv shows when data is gotten successfully',
        () async {
      /// arrange
      _arrangeUseCase();

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      expect(tvShowDetailNotifier.tvShowState, RequestState.Loaded);
      expect(tvShowDetailNotifier.tvShowRecommendations, testTvShowList);
    });
  });

  group('Get Tv Shows Recommendations', () {
    test('should get data from the use case', () async {
      /// arrange
      _arrangeUseCase();

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      verify(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
          tvId: tvId));
      expect(tvShowDetailNotifier.tvShowRecommendations, testTvShowList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      /// arrange
      _arrangeUseCase();

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      expect(tvShowDetailNotifier.recommendationState, RequestState.Loaded);
      expect(tvShowDetailNotifier.tvShowRecommendations, testTvShowList);
    });

    test('should update error message when request in successful', () async {
      /// arrange
      when(mockGetDetailTvShowsUseCase.getDetailTvShows(tvId: tvId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
              tvId: tvId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      expect(tvShowDetailNotifier.recommendationState, RequestState.Error);
      expect(tvShowDetailNotifier.message, 'Failed');
    });
  });

  group('Tv Show Detail Notifier Watchlist', () {
    test('should get the tv show watchlist status', () async {
      /// arrange
      when(mockGetWatchListStatusTvShowsUseCase.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);

      /// act
      await tvShowDetailNotifier.loadWatchlistStatus(1);

      /// assert
      expect(tvShowDetailNotifier.isAddedtoWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      /// arrange
      when(mockSaveWatchListTvShowsUseCase.saveWatchlist(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatusTvShowsUseCase
              .isAddedToWatchlist(testTvShowDetail.id))
          .thenAnswer((_) async => true);

      /// act
      await tvShowDetailNotifier.addWatchlist(testTvShowDetail);

      /// assert
      verify(mockSaveWatchListTvShowsUseCase.saveWatchlist(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      /// arrange
      when(mockRemoveWatchListTvShowsUseCase.removeWatchlist(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatusTvShowsUseCase
              .isAddedToWatchlist(testTvShowDetail.id))
          .thenAnswer((_) async => false);

      /// act
      await tvShowDetailNotifier.removeFromWatchlist(testTvShowDetail);

      /// assert
      verify(
          mockRemoveWatchListTvShowsUseCase.removeWatchlist(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      /// arrange
      when(mockSaveWatchListTvShowsUseCase.saveWatchlist(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListStatusTvShowsUseCase
              .isAddedToWatchlist(testTvShowDetail.id))
          .thenAnswer((_) async => true);

      /// act
      await tvShowDetailNotifier.addWatchlist(testTvShowDetail);

      /// assert
      verify(mockGetWatchListStatusTvShowsUseCase
          .isAddedToWatchlist(testTvShowDetail.id));
      expect(tvShowDetailNotifier.isAddedtoWatchlist, true);
      expect(tvShowDetailNotifier.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      /// arrange
      when(mockSaveWatchListTvShowsUseCase.saveWatchlist(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatusTvShowsUseCase
              .isAddedToWatchlist(testTvShowDetail.id))
          .thenAnswer((_) async => false);

      /// act
      await tvShowDetailNotifier.addWatchlist(testTvShowDetail);

      /// assert
      expect(tvShowDetailNotifier.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error Tv Show Detail Notifier', () {
    test('should return error when data is unsuccessful', () async {
      /// arrange
      when(mockGetDetailTvShowsUseCase.getDetailTvShows(tvId: tvId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
              tvId: tvId))
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      await tvShowDetailNotifier.fetchTvShowDetail(tvId);

      /// assert
      expect(tvShowDetailNotifier.tvShowState, RequestState.Error);
      expect(tvShowDetailNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
