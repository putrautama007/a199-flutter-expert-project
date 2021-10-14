import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvShowsUseCase,
  GetPopularTvShowsUseCase,
  GetTopRatedTvShowsUseCase,
])
void main() {
  late TvShowListNotifier tvShowListNotifier;
  late MockGetNowPlayingTvShowsUseCase mockGetNowPlayingTvShowsUseCase;
  late MockGetPopularTvShowsUseCase mockGetPopularTvShowsUseCase;
  late MockGetTopRatedTvShowsUseCase mockGetTopRatedTvShowsUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvShowsUseCase = MockGetNowPlayingTvShowsUseCase();
    mockGetPopularTvShowsUseCase = MockGetPopularTvShowsUseCase();
    mockGetTopRatedTvShowsUseCase = MockGetTopRatedTvShowsUseCase();
    tvShowListNotifier = TvShowListNotifier(
      getNowPlayingTvShowsUseCase: mockGetNowPlayingTvShowsUseCase,
      getPopularTvShowsUseCase: mockGetPopularTvShowsUseCase,
      getTopRatedTvShowsUseCase: mockGetTopRatedTvShowsUseCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing tv shows', () {
    test('nowPlayingState should be Empty', () {
      expect(tvShowListNotifier.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the use case', () async {
      /// arrange
      when(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      tvShowListNotifier.fetchNowPlayingTvShows();

      /// assert
      verify(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows());
    });

    test('should change state to Loading when use case is called', () {
      /// arrange
      when(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      tvShowListNotifier.fetchNowPlayingTvShows();

      /// assert
      expect(tvShowListNotifier.nowPlayingState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      /// arrange
      when(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      await tvShowListNotifier.fetchNowPlayingTvShows();

      /// assert
      expect(tvShowListNotifier.nowPlayingState, RequestState.Loaded);
      expect(tvShowListNotifier.nowPlayingTvShows, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      /// arrange
      when(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      /// act
      await tvShowListNotifier.fetchNowPlayingTvShows();

      /// assert
      expect(tvShowListNotifier.nowPlayingState, RequestState.Error);
      expect(tvShowListNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv shows', () {
    test('should change state to loading when use case is called', () async {
      /// arrange
      when(mockGetPopularTvShowsUseCase.getPopularTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      tvShowListNotifier.fetchPopulargTvShows();

      /// assert
      expect(tvShowListNotifier.popularState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      /// arrange
      when(mockGetPopularTvShowsUseCase.getPopularTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      await tvShowListNotifier.fetchPopulargTvShows();

      /// assert
      expect(tvShowListNotifier.popularState, RequestState.Loaded);
      expect(tvShowListNotifier.popularTvShows, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      /// arrange
      when(mockGetPopularTvShowsUseCase.getPopularTvShows())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      /// act
      await tvShowListNotifier.fetchPopulargTvShows();

      /// assert
      expect(tvShowListNotifier.popularState, RequestState.Error);
      expect(tvShowListNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv shows', () {
    test('should change state to loading when use case is called', () async {
      /// arrange
      when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      tvShowListNotifier.fetchTopRatedTvShows();

      /// assert
      expect(tvShowListNotifier.topRatedState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      /// arrange
      when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows())
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      await tvShowListNotifier.fetchTopRatedTvShows();

      /// assert
      expect(tvShowListNotifier.topRatedState, RequestState.Loaded);
      expect(tvShowListNotifier.topRatedTvShows, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      /// arrange
      when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      /// act
      await tvShowListNotifier.fetchTopRatedTvShows();

      /// assert
      expect(tvShowListNotifier.topRatedState, RequestState.Error);
      expect(tvShowListNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
