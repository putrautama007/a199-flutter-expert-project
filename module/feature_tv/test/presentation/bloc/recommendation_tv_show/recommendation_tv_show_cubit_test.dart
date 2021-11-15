import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_show/recommendation_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_show/recommendation_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'recommendation_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetRecommendationTvShowsUseCase,
])
void main() {
  late MockGetRecommendationTvShowsUseCase mockGetRecommendationTvShowsUseCase;
  late RecommendationTvShowCubit recommendationTvShowCubit;
  const String tvShowId = "99";

  setUp(() {
    mockGetRecommendationTvShowsUseCase = MockGetRecommendationTvShowsUseCase();
    recommendationTvShowCubit = RecommendationTvShowCubit(
      getRecommendationTvShowsUseCase: mockGetRecommendationTvShowsUseCase,
    );
  });

  blocTest<RecommendationTvShowCubit, RecommendationTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return recommendationTvShowCubit;
    },
    expect: () => [],
  );

  blocTest<RecommendationTvShowCubit, RecommendationTvShowState>(
    'Should emit [RecommendationTvShowLoadingState,RecommendationTvShowLoadedState] when call fetchRecommendationTvShow successfully',
    build: () {
      when(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
              tvId: tvShowId))
          .thenAnswer(
        (_) async => const Right(
          [
            TvEntities(
              backdropPath: "backdropPath",
              genreIds: [1],
              id: 1,
              overview: "overview",
              popularity: 0.0,
              posterPath: "posterPath",
              voteAverage: 0.0,
              voteCount: 0,
              originalLanguage: '',
              originalName: '',
              firstAirDate: '',
              originCountry: [
                '',
              ],
            )
          ],
        ),
      );
      return recommendationTvShowCubit;
    },
    act: (cubit) => cubit.fetchRecommendationTvShow(tvShowId),
    expect: () => [
      isA<RecommendationTvShowLoadingState>(),
      isA<RecommendationTvShowLoadedState>()
    ],
  );

  blocTest<RecommendationTvShowCubit, RecommendationTvShowState>(
    'Should emit [RecommendationTvShowLoadingState,RecommendationTvShowErrorState] when call fetchRecommendationTvShow unsuccessfully',
    build: () {
      when(mockGetRecommendationTvShowsUseCase.getRecommendationTvShows(
              tvId: tvShowId))
          .thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return recommendationTvShowCubit;
    },
    act: (cubit) => cubit.fetchRecommendationTvShow(tvShowId),
    expect: () => [
      isA<RecommendationTvShowLoadingState>(),
      isA<RecommendationTvShowErrorState>()
    ],
  );
}
