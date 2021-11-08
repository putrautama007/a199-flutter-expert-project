import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:feature_movie/presentation/bloc/search_movie/search_cubit.dart';
import 'package:feature_movie/presentation/bloc/search_movie/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'search_cubit_test.mocks.dart';

@GenerateMocks([
  SearchMovies,
])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchCubit searchCubit;
  const String query = "Spider man";

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchCubit = SearchCubit(
      searchMovies: mockSearchMovies,
    );
  });

  blocTest<SearchCubit, SearchState>(
    'Should emit [] when call nothing',
    build: () {
      return searchCubit;
    },
    expect: () => [],
  );

  blocTest<SearchCubit, SearchState>(
    'Should emit [PopularLoadingState,SearchLoadedState] when call searchMovies successfully',
    build: () {
      when(mockSearchMovies.execute(query)).thenAnswer(
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
      return searchCubit;
    },
    act: (cubit) => cubit.fetchMovieSearch(query),
    expect: () => [
      isA<SearchLoadingState>(),
      isA<SearchLoadedState>()
    ],
  );

  blocTest<SearchCubit, SearchState>(
    'Should emit [SearchLoadingState,SearchErrorState] when call searchMovies unsuccessfully',
    build: () {
      when(mockSearchMovies.execute(query)).thenAnswer(
            (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return searchCubit;
    },
    act: (cubit) => cubit.fetchMovieSearch(query),
    expect: () => [
      isA<SearchLoadingState>(),
      isA<SearchErrorState>()
    ],
  );
}
