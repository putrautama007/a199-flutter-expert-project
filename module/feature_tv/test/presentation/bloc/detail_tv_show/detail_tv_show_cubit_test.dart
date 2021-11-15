import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:feature_tv/domain/entities/episode_entities.dart';
import 'package:feature_tv/domain/entities/season_entities.dart';
import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/detail_tv_show/detail_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/detail_tv_show/detail_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'detail_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetDetailTvShowsUseCase,
])
void main() {
  late MockGetDetailTvShowsUseCase mockGetDetailTvShowsUseCase;
  late DetailTVShowCubit detailTVShowCubit;

  setUp(() {
    mockGetDetailTvShowsUseCase = MockGetDetailTvShowsUseCase();
    detailTVShowCubit = DetailTVShowCubit(
      getDetailTvShowsUseCase: mockGetDetailTvShowsUseCase,
    );
  });

  blocTest<DetailTVShowCubit, DetailTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return detailTVShowCubit;
    },
    expect: () => [],
  );

  blocTest<DetailTVShowCubit, DetailTvShowState>(
    'Should emit [DetailTvShowLoadingState,DetailTvShowLoadedState] when call fetchTvShowDetail successfully',
    build: () {
      when(mockGetDetailTvShowsUseCase.getDetailTvShows(tvId: "999"))
          .thenAnswer(
        (_) async => const Right(
          TvDetailEntities(
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
          ),
        ),
      );
      return detailTVShowCubit;
    },
    act: (cubit) => cubit.fetchTvShowDetail("999"),
    expect: () =>
        [isA<DetailTvShowLoadingState>(), isA<DetailTvShowLoadedState>()],
  );

  blocTest<DetailTVShowCubit, DetailTvShowState>(
    'Should emit [DetailTvShowLoadingState,DetailTvShowErrorState] when call fetchTvShowDetail unsuccessfully',
    build: () {
      when(mockGetDetailTvShowsUseCase.getDetailTvShows(tvId: "999"))
          .thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return detailTVShowCubit;
    },
    act: (cubit) => cubit.fetchTvShowDetail("999"),
    expect: () =>
        [isA<DetailTvShowLoadingState>(), isA<DetailTvShowErrorState>()],
  );
}
