import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTvShowsUseCase getWatchListTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getWatchListTvShowsUseCase = GetWatchListTvShowsUseCaseImpl(
      tvRepositories: mockTvRepositories,
    );
  });

  test('should get list of tv shows from the tv repository', () async {
    /// arrange
    when(mockTvRepositories.getWatchlistTvShows())
        .thenAnswer((_) async => Right(testTvShowList));
    /// act
    final result = await getWatchListTvShowsUseCase.getWatchlistTvShows();
    /// assert
    expect(result, Right(testTvShowList));
  });
}
