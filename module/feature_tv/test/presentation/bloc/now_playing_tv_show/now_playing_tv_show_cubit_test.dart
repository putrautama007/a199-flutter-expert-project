import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/now_playing_tv_show/now_playing_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/now_playing_tv_show/now_playing_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'now_playing_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvShowsUseCase,
])
void main() {
  late MockGetNowPlayingTvShowsUseCase mockGetNowPlayingTvShowsUseCase;
  late NowPlayingTvShowCubit nowPlayingTvShowCubit;

  setUp(() {
    mockGetNowPlayingTvShowsUseCase = MockGetNowPlayingTvShowsUseCase();
    nowPlayingTvShowCubit = NowPlayingTvShowCubit(
      getNowPlayingTvShowsUseCase: mockGetNowPlayingTvShowsUseCase,
    );
  });

  blocTest<NowPlayingTvShowCubit, NowPlayingTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return nowPlayingTvShowCubit;
    },
    expect: () => [],
  );

  blocTest<NowPlayingTvShowCubit, NowPlayingTvShowState>(
    'Should emit [NowPlayingTvShowLoadingState,NowPlayingTvShowLoadedState] when call fetchNowPlayingTvShow successfully',
    build: () {
      when(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows()).thenAnswer(
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
              originCountry: [
                "",
              ],
              firstAirDate: '',
              originalName: '',
              originalLanguage: '',
            )
          ],
        ),
      );
      return nowPlayingTvShowCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvShow(),
    expect: () => [
      isA<NowPlayingTvShowLoadingState>(),
      isA<NowPlayingTvShowLoadedState>()
    ],
  );

  blocTest<NowPlayingTvShowCubit, NowPlayingTvShowState>(
    'Should emit [NowPlayingTvShowLoadingState,NowPlayingTvShowErrorState] when call fetchNowPlayingTvShow unsuccessfully',
    build: () {
      when(mockGetNowPlayingTvShowsUseCase.getNowPlayingTvShows()).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return nowPlayingTvShowCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvShow(),
    expect: () => [
      isA<NowPlayingTvShowLoadingState>(),
      isA<NowPlayingTvShowErrorState>()
    ],
  );
}
