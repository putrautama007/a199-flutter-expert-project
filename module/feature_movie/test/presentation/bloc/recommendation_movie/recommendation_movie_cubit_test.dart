import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:feature_movie/presentation/bloc/recommendation_movie/recommendation_movie_cubit.dart';
import 'package:feature_movie/presentation/bloc/recommendation_movie/recommendation_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'recommendation_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationMovieCubit recommendationMovieCubit;
  const int movieId = 99;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieCubit = RecommendationMovieCubit(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  blocTest<RecommendationMovieCubit, RecommendationMovieState>(
    'Should emit [] when call nothing',
    build: () {
      return recommendationMovieCubit;
    },
    expect: () => [],
  );

  blocTest<RecommendationMovieCubit, RecommendationMovieState>(
    'Should emit [PopularLoadingState,PopularLoadedState] when call fetchRecommendationMovie successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(movieId)).thenAnswer(
        (_) async => const Right(
          [
            Movie(
              adult: false,
              backdropPath: "backdropPath",
              genreIds: [1],
              id: 1,
              originalTitle: "originalTitle",
              overview: "overview",
              popularity: 0.0,
              posterPath: "posterPath",
              releaseDate: "releaseDate",
              title: "title",
              video: false,
              voteAverage: 0.0,
              voteCount: 0,
            )
          ],
        ),
      );
      return recommendationMovieCubit;
    },
    act: (cubit) => cubit.fetchRecommendationMovie(movieId),
    expect: () => [
      isA<RecommendationMovieLoadingState>(),
      isA<RecommendationMovieLoadedState>()
    ],
  );

  blocTest<RecommendationMovieCubit, RecommendationMovieState>(
    'Should emit [PopularLoadingState,RecommendationMovieErrorState] when call fetchRecommendationMovie unsuccessfully',
    build: () {
      when(mockGetMovieRecommendations.execute(movieId)).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return recommendationMovieCubit;
    },
    act: (cubit) => cubit.fetchRecommendationMovie(movieId),
    expect: () => [
      isA<RecommendationMovieLoadingState>(),
      isA<RecommendationMovieErrorState>()
    ],
  );
}
