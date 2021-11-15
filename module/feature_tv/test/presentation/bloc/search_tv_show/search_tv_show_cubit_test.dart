import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/search_tv_show/search_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/search_tv_show/search_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'search_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  SearchTvShowsUseCase,
])
void main() {
  late MockSearchTvShowsUseCase mockSearchTvShowsUseCase;
  late SearchTvShowCubit searchTvShowCubit;
  const String query = "Spider man";

  setUp(() {
    mockSearchTvShowsUseCase = MockSearchTvShowsUseCase();
    searchTvShowCubit = SearchTvShowCubit(
      searchTvShowsUseCase: mockSearchTvShowsUseCase,
    );
  });

  blocTest<SearchTvShowCubit, SearchTvShowState>(
    'Should emit [] when call nothing',
    build: () {
      return searchTvShowCubit;
    },
    expect: () => [],
  );

  blocTest<SearchTvShowCubit, SearchTvShowState>(
    'Should emit [SearchTvShowLoadingState,SearchTvShowLoadedState] when call fetchTvShowSearch successfully',
    build: () {
      when(mockSearchTvShowsUseCase.searchTvShows(query)).thenAnswer(
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
              firstAirDate: '',
              originalName: '',
              originalLanguage: '',
              originCountry: [
                '',
              ],
            )
          ],
        ),
      );
      return searchTvShowCubit;
    },
    act: (cubit) => cubit.fetchTvShowSearch(query),
    expect: () =>
        [isA<SearchTvShowLoadingState>(), isA<SearchTvShowLoadedState>()],
  );

  blocTest<SearchTvShowCubit, SearchTvShowState>(
    'Should emit [SearchTvShowLoadingState,SearchTvShowErrorState] when call fetchTvShowSearch unsuccessfully',
    build: () {
      when(mockSearchTvShowsUseCase.searchTvShows(query)).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return searchTvShowCubit;
    },
    act: (cubit) => cubit.fetchTvShowSearch(query),
    expect: () =>
        [isA<SearchTvShowLoadingState>(), isA<SearchTvShowErrorState>()],
  );
}
