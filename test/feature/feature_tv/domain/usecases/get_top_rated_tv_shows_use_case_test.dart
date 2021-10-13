import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShowsUseCase getTopRatedTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getTopRatedTvShowsUseCase =
        GetTopRatedTvShowsUseCaseImpl(tvRepositories: mockTvRepositories);
  });

  final tvShows = <TvEntities>[];

  test('should get list of tv shows from tv repository', () async {
    /// arrange
    when(mockTvRepositories.getTopRatedTvShows())
        .thenAnswer((_) async => Right(tvShows));

    /// act
    final result = await getTopRatedTvShowsUseCase.getTopRatedTvShows();

    /// assert
    expect(result, Right(tvShows));
  });
}
