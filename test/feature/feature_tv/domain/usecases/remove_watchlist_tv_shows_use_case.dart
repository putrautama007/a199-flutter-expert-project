import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchListTvShowsUseCase removeWatchListTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    removeWatchListTvShowsUseCase = RemoveWatchListTvShowsUseCaseImpl(
      tvRepositories: mockTvRepositories,
    );
  });

  test('should remove watchlist tv show from repository', () async {
    /// arrange
    when(mockTvRepositories.removeWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));

    /// act
    final result =
        await removeWatchListTvShowsUseCase.removeWatchlist(testTvShowDetail);

    /// assert
    verify(mockTvRepositories.removeWatchlist(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
