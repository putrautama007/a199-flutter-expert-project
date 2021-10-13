import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvShowsUseCase getWatchListStatusTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getWatchListStatusTvShowsUseCase = GetWatchListStatusTvShowsUseCaseImpl(
      tvRepositories: mockTvRepositories,
    );
  });

  test('should get watchlist status from repository', () async {
    /// arrange
    when(mockTvRepositories.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);

    /// act
    final result = await getWatchListStatusTvShowsUseCase.isAddedToWatchlist(1);

    /// assert
    expect(result, true);
  });
}
