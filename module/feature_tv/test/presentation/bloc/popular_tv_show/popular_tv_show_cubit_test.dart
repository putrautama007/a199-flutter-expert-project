import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_show/popular_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_show/popular_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'popular_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetPopularTvShowsUseCase,
])
void main() {
  late MockGetPopularTvShowsUseCase mockGetPopularTvShowsUseCase;
  late PopularTvShowCubit popularTvShowCubit;

  setUp(() {
    mockGetPopularTvShowsUseCase = MockGetPopularTvShowsUseCase();
    popularTvShowCubit = PopularTvShowCubit(
      getPopularTvShowsUseCase: mockGetPopularTvShowsUseCase,
    );
  });

  blocTest<PopularTvShowCubit, PopularTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return popularTvShowCubit;
    },
    expect: () => [],
  );

  blocTest<PopularTvShowCubit, PopularTvShowState>(
    'Should emit [PopularTvShowLoadingState,PopularTvShowLoadedState] when call fetchPopularTvShow successfully',
    build: () {
      when(mockGetPopularTvShowsUseCase.getPopularTvShows()).thenAnswer(
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
              originCountry: [
                '',
              ],
              firstAirDate: '',
              originalName: '',
            )
          ],
        ),
      );
      return popularTvShowCubit;
    },
    act: (cubit) => cubit.fetchPopularTvShow(),
    expect: () =>
        [isA<PopularTvShowLoadingState>(), isA<PopularTvShowLoadedState>()],
  );

  blocTest<PopularTvShowCubit, PopularTvShowState>(
    'Should emit [PopularTvShowLoadingState,PopularTvShowErrorState] when call fetchPopularTvShow unsuccessfully',
    build: () {
      when(mockGetPopularTvShowsUseCase.getPopularTvShows()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return popularTvShowCubit;
    },
    act: (cubit) => cubit.fetchPopularTvShow(),
    expect: () =>
        [isA<PopularTvShowLoadingState>(), isA<PopularTvShowErrorState>()],
  );
}
