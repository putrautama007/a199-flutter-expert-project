import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:feature_movie/presentation/bloc/is_add_watch_list/is_add_watch_list_cubit.dart';
import 'package:feature_movie/presentation/bloc/is_add_watch_list/is_add_watch_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'is_add_watch_list_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late IsAddWatchlistCubit isAddWatchlistCubit;
  late MovieDetail movieDetail;

  setUp(() {
    movieDetail = const MovieDetail(
      title: '',
      posterPath: '',
      runtime: 0,
      genres: [Genre(id: 0, name: "")],
      overview: '',
      originalTitle: '',
      id: 0,
      releaseDate: '',
      voteCount: 0,
      voteAverage: 0,
      adult: true,
      backdropPath: '',
    );
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    isAddWatchlistCubit = IsAddWatchlistCubit(
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [] when call nothing',
    build: () {
      return isAddWatchlistCubit;
    },
    expect: () => [],
  );

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [IsAddWatchListAddMovieState,IsAddWatchListLoadingState] when call addWatchlist successfully',
    build: () {
      when(mockSaveWatchlist.execute(movieDetail)).thenAnswer(
        (_) async => const Right(""),
      );
      return isAddWatchlistCubit;
    },
    act: (cubit) => cubit.addWatchlist(movieDetail),
    expect: () => [
      isA<IsAddWatchListAddMovieState>(),
      isA<IsAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [IsAddWatchListErrorState,IsAddWatchListLoadingState] when call addWatchlist unsuccessfully',
    build: () {
      when(mockSaveWatchlist.execute(movieDetail)).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );

      return isAddWatchlistCubit;
    },
    act: (cubit) => cubit.addWatchlist(movieDetail),
    expect: () => [
      isA<IsAddWatchListErrorState>(),
      isA<IsAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [IsAddWatchListRemoveMovieState,IsAddWatchListLoadingState] when call removeFromWatchlist successfully',
    build: () {
      when(mockRemoveWatchlist.execute(movieDetail)).thenAnswer(
        (_) async => const Right(""),
      );
      return isAddWatchlistCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(movieDetail),
    expect: () => [
      isA<IsAddWatchListRemoveMovieState>(),
      isA<IsAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [IsAddWatchListErrorState,IsAddWatchListLoadingState] when call removeFromWatchlist unsuccessfully',
    build: () {
      when(mockRemoveWatchlist.execute(movieDetail)).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );

      return isAddWatchlistCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(movieDetail),
    expect: () => [
      isA<IsAddWatchListErrorState>(),
      isA<IsAddWatchListLoadingState>(),
    ],
  );

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [IsAddWatchListLoadingState,IsAddWatchListRemoveMovieState] when call loadWatchlistStatus successfully',
    build: () {
      when(mockGetWatchListStatus.execute(movieDetail.id)).thenAnswer(
        (_) async => true,
      );
      return isAddWatchlistCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(movieDetail.id),
    expect: () => [
      isA<IsAddWatchListLoadingState>(),
      isA<IsAddWatchListRemoveMovieState>(),
    ],
  );

  blocTest<IsAddWatchlistCubit, IsAddWatchListState>(
    'Should emit [IsAddWatchListLoadingState,IsAddWatchListAddMovieState] when call loadWatchlistStatus unsuccessfully',
    build: () {
      when(mockGetWatchListStatus.execute(movieDetail.id)).thenAnswer(
        (_) async => false,
      );

      return isAddWatchlistCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(movieDetail.id),
    expect: () => [
      isA<IsAddWatchListLoadingState>(),
      isA<IsAddWatchListAddMovieState>(),
    ],
  );
}
