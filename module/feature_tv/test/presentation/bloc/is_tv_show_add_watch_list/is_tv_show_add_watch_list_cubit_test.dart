import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/episode_entities.dart';
import 'package:feature_tv/domain/entities/season_entities.dart';
import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_cubit.dart';
import 'package:feature_tv/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'is_tv_show_add_watch_list_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTvShowsUseCase,
  SaveWatchListTvShowsUseCase,
  RemoveWatchListTvShowsUseCase,
])
void main() {
  late MockGetWatchListStatusTvShowsUseCase
      mockGetWatchListStatusTvShowsUseCase;
  late MockSaveWatchListTvShowsUseCase mockSaveWatchListTvShowsUseCase;
  late MockRemoveWatchListTvShowsUseCase mockRemoveWatchListTvShowsUseCase;
  late IsTvShowAddWatchlistCubit isTvShowAddWatchlistCubit;
  late TvDetailEntities tvDetailEntities;

  setUp(() {
    tvDetailEntities = const TvDetailEntities(
      posterPath: '',
      genres: [Genre(id: 0, name: "")],
      overview: '',
      id: 0,
      voteCount: 0,
      voteAverage: 0,
      backdropPath: '',
      status: '',
      popularity: 0.0,
      nextEpisodeToAir: EpisodeEntities(
        airDate: "airDate",
        episodeNumber: 0,
        id: 0,
        name: "name",
        overview: "overview",
        productionCode: "productionCode",
        seasonNumber: 0,
        stillPath: "stillPath",
        voteAverage: 0.0,
        voteCount: 1,
      ),
      seasons: [
        SeasonEntities(
          airDate: "airDate",
          episodeCount: 0,
          id: 0,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 0,
        ),
      ],
      tagline: '',
      originCountry: [
        '',
      ],
      firstAirDate: '',
      homepage: '',
      lastAirDate: '',
      numberOfEpisodes: 0,
      originalLanguage: '',
      name: '',
      lastEpisodeToAir: EpisodeEntities(
        airDate: "airDate",
        episodeNumber: 0,
        id: 0,
        name: "name",
        overview: "overview",
        productionCode: "productionCode",
        seasonNumber: 0,
        stillPath: "stillPath",
        voteAverage: 0.0,
        voteCount: 1,
      ),
      numberOfSeasons: 0,
      inProduction: false,
      episodeRunTime: [
        0,
      ],
      originalName: '',
      type: '',
      languages: [
        '',
      ],
    );
    mockGetWatchListStatusTvShowsUseCase =
        MockGetWatchListStatusTvShowsUseCase();
    mockSaveWatchListTvShowsUseCase = MockSaveWatchListTvShowsUseCase();
    mockRemoveWatchListTvShowsUseCase = MockRemoveWatchListTvShowsUseCase();
    isTvShowAddWatchlistCubit = IsTvShowAddWatchlistCubit(
      removeWatchListTvShowsUseCase: mockRemoveWatchListTvShowsUseCase,
      saveWatchListTvShowsUseCase: mockSaveWatchListTvShowsUseCase,
      getWatchListStatusTvShowsUseCase: mockGetWatchListStatusTvShowsUseCase,
    );
  });

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [] when call nothing',
    build: () {
      return isTvShowAddWatchlistCubit;
    },
    expect: () => [],
  );

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [IsTvShowAddWatchListAddTvShowState,IsTvShowAddWatchListLoadingState] when call addWatchlist successfully',
    build: () {
      when(mockSaveWatchListTvShowsUseCase.saveWatchlist(tvDetailEntities))
          .thenAnswer(
        (_) async => const Right(""),
      );
      return isTvShowAddWatchlistCubit;
    },
    act: (cubit) => cubit.addWatchlist(tvDetailEntities),
    expect: () => [
      isA<IsTvShowAddWatchListAddTvShowState>(),
      isA<IsTvShowAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [IsTvShowAddWatchListErrorState,IsTvShowAddWatchListLoadingState] when call addWatchlist unsuccessfully',
    build: () {
      when(mockSaveWatchListTvShowsUseCase.saveWatchlist(tvDetailEntities))
          .thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );

      return isTvShowAddWatchlistCubit;
    },
    act: (cubit) => cubit.addWatchlist(tvDetailEntities),
    expect: () => [
      isA<IsTvShowAddWatchListErrorState>(),
      isA<IsTvShowAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [IsTvShowAddWatchListRemoveTvShowState,IsTvShowAddWatchListLoadingState] when call removeFromWatchlist successfully',
    build: () {
      when(mockRemoveWatchListTvShowsUseCase.removeWatchlist(tvDetailEntities))
          .thenAnswer(
        (_) async => const Right(""),
      );
      return isTvShowAddWatchlistCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(tvDetailEntities),
    expect: () => [
      isA<IsTvShowAddWatchListRemoveTvShowState>(),
      isA<IsTvShowAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [IsTvShowAddWatchListErrorState,IsTvShowAddWatchListLoadingState] when call removeFromWatchlist unsuccessfully',
    build: () {
      when(mockRemoveWatchListTvShowsUseCase.removeWatchlist(tvDetailEntities))
          .thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );

      return isTvShowAddWatchlistCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(tvDetailEntities),
    expect: () => [
      isA<IsTvShowAddWatchListErrorState>(),
      isA<IsTvShowAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [IsTvShowAddWatchListLoadingState,IsTvShowAddWatchListRemoveTvShowState] when call loadWatchlistStatus successfully',
    build: () {
      when(mockGetWatchListStatusTvShowsUseCase
              .isAddedToWatchlist(tvDetailEntities.id))
          .thenAnswer(
        (_) async => true,
      );
      return isTvShowAddWatchlistCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(tvDetailEntities.id.toString()),
    expect: () => [
      isA<IsTvShowAddWatchListLoadingState>(),
      isA<IsTvShowAddWatchListRemoveTvShowState>(),
    ],
  );

  blocTest<IsTvShowAddWatchlistCubit, IsTvShowAddWatchListState>(
    'Should emit [IsTvShowAddWatchListLoadingState,IsTvShowAddWatchListAddTvShowState] when call loadWatchlistStatus unsuccessfully',
    build: () {
      when(mockGetWatchListStatusTvShowsUseCase
              .isAddedToWatchlist(tvDetailEntities.id))
          .thenAnswer(
        (_) async => false,
      );

      return isTvShowAddWatchlistCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(tvDetailEntities.id.toString()),
    expect: () => [
      isA<IsTvShowAddWatchListLoadingState>(),
      isA<IsTvShowAddWatchListAddTvShowState>(),
    ],
  );
}
