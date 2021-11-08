import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_cubit.dart';
import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'top_rated_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedCubit topRatedCubit;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedCubit = TopRatedCubit(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  blocTest<TopRatedCubit, TopRatedState>(
    'Should emit [] when call nothing',
    build: () {
      return topRatedCubit;
    },
    expect: () => [],
  );

  blocTest<TopRatedCubit, TopRatedState>(
    'Should emit [TopRatedLoadingState,TopRatedLoadedState] when call fetchTopRatedMovies successfully',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
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
      return topRatedCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      isA<TopRatedLoadingState>(),
      isA<TopRatedLoadedState>()
    ],
  );

  blocTest<TopRatedCubit, TopRatedState>(
    'Should emit [TopRatedLoadingState,TopRatedErrorState] when call fetchTopRatedMovies unsuccessfully',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return topRatedCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      isA<TopRatedLoadingState>(),
      isA<TopRatedErrorState>()
    ],
  );
}
