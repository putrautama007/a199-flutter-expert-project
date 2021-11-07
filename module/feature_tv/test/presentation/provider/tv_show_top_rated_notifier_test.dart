import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/provider/tv_show_top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helper/dummy_data/dummy_objects.dart';
import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShowsUseCase])
void main() {
  late MockGetTopRatedTvShowsUseCase mockGetTopRatedTvShowsUseCase;
  late TvShowTopRatedNotifier tvShowTopRatedNotifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvShowsUseCase = MockGetTopRatedTvShowsUseCase();
    tvShowTopRatedNotifier = TvShowTopRatedNotifier(
      getTopRatedTvShowsUseCase: mockGetTopRatedTvShowsUseCase,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when use case is called', () async {
    /// arrange
    when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows())
        .thenAnswer((_) async => Right(testTvShowList));

    /// act
    tvShowTopRatedNotifier.fetchTopRatedTvShows();

    /// assert
    expect(tvShowTopRatedNotifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    /// arrange
    when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows())
        .thenAnswer((_) async => Right(testTvShowList));

    /// act
    await tvShowTopRatedNotifier.fetchTopRatedTvShows();

    /// assert
    expect(tvShowTopRatedNotifier.state, RequestState.loaded);
    expect(tvShowTopRatedNotifier.tvShow, testTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    /// arrange
    when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

    /// act
    await tvShowTopRatedNotifier.fetchTopRatedTvShows();

    /// assert
    expect(tvShowTopRatedNotifier.state, RequestState.error);
    expect(tvShowTopRatedNotifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
