import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShowsUseCase searchTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    searchTvShowsUseCase = SearchTvShowsUseCaseImpl(
      tvRepositories: mockTvRepositories,
    );
  });

  final tvShows = <TvEntities>[];
  final tvShowQuery = 'Squide Game';

  test('should get list of tv shows from the tv repository', () async {
    /// arrange
    when(mockTvRepositories.searchTvShows(tvShowQuery))
        .thenAnswer((_) async => Right(tvShows));

    /// act
    final result = await searchTvShowsUseCase.searchTvShows(tvShowQuery);

    /// assert
    expect(result, Right(tvShows));
  });
}
