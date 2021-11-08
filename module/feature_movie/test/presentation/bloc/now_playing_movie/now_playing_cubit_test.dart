import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/presentation/bloc/now_playing_movie/now_playing_cubit.dart';
import 'package:feature_movie/presentation/bloc/now_playing_movie/now_playing_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'now_playing_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingCubit nowPlayingCubit;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingCubit = NowPlayingCubit(
      getNowPlayingMovies: mockGetNowPlayingMovies,
    );
  });

  blocTest<NowPlayingCubit, NowPlayingState>(
    'Should emit [] when call nothing',
    build: () {
      return nowPlayingCubit;
    },
    expect: () => [],
  );

  blocTest<NowPlayingCubit, NowPlayingState>(
    'Should emit [DetailMovieInitialState,DetailMovieLoadedState] when call fetchMovieDetail successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
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
      return nowPlayingCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [isA<NowPlayingLoadingState>(), isA<NowPlayingLoadedState>()],
  );

  blocTest<NowPlayingCubit, NowPlayingState>(
    'Should emit [DetailMovieInitialState,DetailMovieErrorState] when call fetchMovieDetail unsuccessfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return nowPlayingCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [isA<NowPlayingLoadingState>(), isA<NowPlayingErrorState>()],
  );
}
