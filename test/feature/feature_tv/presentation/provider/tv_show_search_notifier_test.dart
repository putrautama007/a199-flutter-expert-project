import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShowsUseCase])
void main() {
  late TvShowSearchNotifier tvShowSearchNotifier;
  late MockSearchTvShowsUseCase mockSearchTvShowsUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShowsUseCase = MockSearchTvShowsUseCase();
    tvShowSearchNotifier = TvShowSearchNotifier(
      searchTvShowsUseCase: mockSearchTvShowsUseCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tvQuery = 'Squid Game';

  group('search tv shows', () {
    test('should change state to loading when use case is called', () async {
      /// arrange
      when(mockSearchTvShowsUseCase.searchTvShows(tvQuery))
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      tvShowSearchNotifier.fetchTvShowSearch(tvQuery);

      /// assert
      expect(tvShowSearchNotifier.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      /// arrange
      when(mockSearchTvShowsUseCase.searchTvShows(tvQuery))
          .thenAnswer((_) async => Right(testTvShowList));

      /// act
      await tvShowSearchNotifier.fetchTvShowSearch(tvQuery);

      /// assert
      expect(tvShowSearchNotifier.state, RequestState.Loaded);
      expect(tvShowSearchNotifier.searchResult, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      /// arrange
      when(mockSearchTvShowsUseCase.searchTvShows(tvQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      /// act
      await tvShowSearchNotifier.fetchTvShowSearch(tvQuery);

      /// assert
      expect(tvShowSearchNotifier.state, RequestState.Error);
      expect(tvShowSearchNotifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
