import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

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
        .thenAnswer((_) async => Right('Added to Watchlist'));

    /// act
    final result =
        await saveWatchListTvShowsUseCase.saveWatchlist(testTvShowDetail);

    /// assert
    verify(mockTvRepositories.saveWatchlist(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
