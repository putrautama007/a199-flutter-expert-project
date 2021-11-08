import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/presentation/bloc/popular_movie/popular_cubit.dart';
import 'package:feature_movie/presentation/bloc/popular_movie/popular_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'popular_cubit_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularCubit popularCubit;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularCubit = PopularCubit(
      getPopularMovies: mockGetPopularMovies,
    );
  });

  blocTest<PopularCubit, PopularState>(
    'Should emit [] when call nothing',
    build: () {
      return popularCubit;
    },
    expect: () => [],
  );

  blocTest<PopularCubit, PopularState>(
    'Should emit [PopularLoadingState,PopularLoadedState] when call fetchMovieDetail successfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
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
      return popularCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () => [isA<PopularLoadingState>(), isA<PopularLoadedState>()],
  );

  blocTest<PopularCubit, PopularState>(
    'Should emit [PopularLoadingState,PopularErrorState] when call fetchMovieDetail unsuccessfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return popularCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () => [isA<PopularLoadingState>(), isA<PopularErrorState>()],
  );
}
