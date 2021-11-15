import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/watch_list_tv_show/watch_list_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/watch_list_tv_show/watch_list_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'watch_list_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListTvShowsUseCase,
])
void main() {
  late MockGetWatchListTvShowsUseCase mockGetWatchListTvShowsUseCase;
  late WatchListTvShowCubit watchListTvShowCubit;

  setUp(() {
    mockGetWatchListTvShowsUseCase = MockGetWatchListTvShowsUseCase();
    watchListTvShowCubit = WatchListTvShowCubit(
      getWatchListTvShowsUseCase: mockGetWatchListTvShowsUseCase,
    );
  });

  blocTest<WatchListTvShowCubit, WatchListTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return watchListTvShowCubit;
    },
    expect: () => [],
  );

  blocTest<WatchListTvShowCubit, WatchListTvShowState>(
    'Should emit [WatchListTvShowLoadingState,WatchListTvShowLoadedState] when call fetchWatchlistTvShow successfully',
    build: () {
      when(mockGetWatchListTvShowsUseCase.getWatchlistTvShows()).thenAnswer(
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
              firstAirDate: '',
              originalName: '',
              originCountry: [
                '',
              ],
            )
          ],
        ),
      );
      return watchListTvShowCubit;
    },
    act: (cubit) => cubit.fetchWatchlistTvShow(),
    expect: () =>
        [isA<WatchListTvShowLoadingState>(), isA<WatchListTvShowLoadedState>()],
  );

  blocTest<WatchListTvShowCubit, WatchListTvShowState>(
    'Should emit [WatchListTvShowLoadingState,WatchListTvShowErrorState] when call fetchWatchlistTvShow unsuccessfully',
    build: () {
      when(mockGetWatchListTvShowsUseCase.getWatchlistTvShows()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return watchListTvShowCubit;
    },
    act: (cubit) => cubit.fetchWatchlistTvShow(),
    expect: () =>
        [isA<WatchListTvShowLoadingState>(), isA<WatchListTvShowErrorState>()],
  );
}
