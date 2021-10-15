import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import 'tv_show_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchListTvShowsUseCase])
void main() {
  late TvShowWatchListNotifier tvShowWatchListNotifier;
  late MockGetWatchListTvShowsUseCase mockGetWatchListTvShowsUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTvShowsUseCase = MockGetWatchListTvShowsUseCase();
    tvShowWatchListNotifier = TvShowWatchListNotifier(
      getWatchListTvShowsUseCase: mockGetWatchListTvShowsUseCase,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    /// arrange
    when(mockGetWatchListTvShowsUseCase.getWatchlistTvShows())
        .thenAnswer((_) async => const Right([testWatchlistTvShow]));

    /// act
    await tvShowWatchListNotifier.fetchWatchlistTvShows();

    /// assert
    expect(tvShowWatchListNotifier.watchlistState, RequestState.loaded);
    expect(tvShowWatchListNotifier.watchlistTvShows, [testWatchlistTvShow]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    /// arrange
    when(mockGetWatchListTvShowsUseCase.getWatchlistTvShows())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));

    /// act
    await tvShowWatchListNotifier.fetchWatchlistTvShows();

    /// assert
    expect(tvShowWatchListNotifier.watchlistState, RequestState.error);
    expect(tvShowWatchListNotifier.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
