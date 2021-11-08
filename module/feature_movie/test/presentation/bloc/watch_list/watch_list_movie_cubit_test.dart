import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/presentation/bloc/watch_list/watch_list_movie_cubit.dart';
import 'package:feature_movie/presentation/bloc/watch_list/watch_list_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'watch_list_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchListMovieCubit watchListMovieCubit;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchListMovieCubit = WatchListMovieCubit(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  blocTest<WatchListMovieCubit, WatchListMovieState>(
    'Should emit [] when call nothing',
    build: () {
      return watchListMovieCubit;
    },
    expect: () => [],
  );

  blocTest<WatchListMovieCubit, WatchListMovieState>(
    'Should emit [WatchListLoadingState,WatchListLoadedState] when call fetchWatchlistMovies successfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
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
      return watchListMovieCubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [isA<WatchListLoadingState>(), isA<WatchListLoadedState>()],
  );

  blocTest<WatchListMovieCubit, WatchListMovieState>(
    'Should emit [WatchListLoadingState,WatchListErrorState] when call fetchWatchlistMovies unsuccessfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return watchListMovieCubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovies(),
    expect: () => [isA<WatchListLoadingState>(), isA<WatchListErrorState>()],
  );
}
