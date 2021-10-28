import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetRecommendationTvShowsUseCase getRecommendationTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getRecommendationTvShowsUseCase =
        GetRecommendationTvShowsUseCaseImpl(tvRepositories: mockTvRepositories);
  });

  const tvId = "1";
  final tvShows = <TvEntities>[];

  test('should get list of tv shows recommendations from the tv repository',
      () async {
    /// arrange
    when(mockTvRepositories.getRecommendationTvShows(tvId: tvId))
        .thenAnswer((_) async => Right(tvShows));

    /// act
    final result = await getRecommendationTvShowsUseCase
        .getRecommendationTvShows(tvId: tvId);

    /// assert
    expect(result, Right(tvShows));
  });
}
