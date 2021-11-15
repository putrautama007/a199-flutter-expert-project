import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_show/top_rated_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_show/top_rated_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'top_rated_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetTopRatedTvShowsUseCase,
])
void main() {
  late MockGetTopRatedTvShowsUseCase mockGetTopRatedTvShowsUseCase;
  late TopRatedTvShowCubit topRatedTvShowCubit;

  setUp(() {
    mockGetTopRatedTvShowsUseCase = MockGetTopRatedTvShowsUseCase();
    topRatedTvShowCubit = TopRatedTvShowCubit(
      getTopRatedTvShowsUseCase: mockGetTopRatedTvShowsUseCase,
    );
  });

  blocTest<TopRatedTvShowCubit, TopRatedTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return topRatedTvShowCubit;
    },
    expect: () => [],
  );

  blocTest<TopRatedTvShowCubit, TopRatedTvShowState>(
    'Should emit [TopRatedTvShowLoadingState,TopRatedTvShowLoadedState] when call fetchTopRatedTvShow successfully',
    build: () {
      when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows()).thenAnswer(
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
              originalName: '',
              firstAirDate: '',
              originalLanguage: '',
              originCountry: [
                '',
              ],
            )
          ],
        ),
      );
      return topRatedTvShowCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvShow(),
    expect: () =>
        [isA<TopRatedTvShowLoadingState>(), isA<TopRatedTvShowLoadedState>()],
  );

  blocTest<TopRatedTvShowCubit, TopRatedTvShowState>(
    'Should emit [TopRatedTvShowLoadingState,TopRatedTvShowErrorState] when call fetchTopRatedTvShow unsuccessfully',
    build: () {
      when(mockGetTopRatedTvShowsUseCase.getTopRatedTvShows()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return topRatedTvShowCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvShow(),
    expect: () =>
        [isA<TopRatedTvShowLoadingState>(), isA<TopRatedTvShowErrorState>()],
  );
}
