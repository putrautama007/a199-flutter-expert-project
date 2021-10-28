import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SaveWatchListTvShowsUseCase saveWatchListTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    saveWatchListTvShowsUseCase = SaveWatchListTvShowsUseCaseImpl(
      tvRepositories: mockTvRepositories,
    );
  });

  test('should save tv show to the repository', () async {
    /// arrange
    when(mockTvRepositories.saveWatchlist(testTvShowDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));

    /// act
    final result =
        await saveWatchListTvShowsUseCase.saveWatchlist(testTvShowDetail);

    /// assert
    verify(mockTvRepositories.saveWatchlist(testTvShowDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
