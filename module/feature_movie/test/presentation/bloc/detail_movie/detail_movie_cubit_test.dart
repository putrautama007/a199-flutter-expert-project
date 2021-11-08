import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/presentation/bloc/detail_movie/detail_movie_cubit.dart';
import 'package:feature_movie/presentation/bloc/detail_movie/detail_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'detail_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMovieCubit detailMovieCubit;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieCubit = DetailMovieCubit(
      getMovieDetail: mockGetMovieDetail,
    );
  });

  blocTest<DetailMovieCubit, DetailMovieState>(
    'Should emit [] when call nothing',
    build: () {
      return detailMovieCubit;
    },
    expect: () => [],
  );

  blocTest<DetailMovieCubit, DetailMovieState>(
    'Should emit [DetailMovieInitialState,DetailMovieLoadedState] when call fetchMovieDetail successfully',
    build: () {
      when(mockGetMovieDetail.execute(999)).thenAnswer(
        (_) async => const Right(
          MovieDetail(
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
          ),
        ),
      );
      return detailMovieCubit;
    },
    act: (cubit) => cubit.fetchMovieDetail(999),
    expect: () =>
        [isA<DetailMovieInitialState>(), isA<DetailMovieLoadedState>()],
  );

  blocTest<DetailMovieCubit, DetailMovieState>(
    'Should emit [DetailMovieInitialState,DetailMovieErrorState] when call fetchMovieDetail unsuccessfully',
    build: () {
      when(mockGetMovieDetail.execute(999)).thenAnswer(
        (_) async => const Left(
          ServerFailure(""),
        ),
      );
      return detailMovieCubit;
    },
    act: (cubit) => cubit.fetchMovieDetail(999),
    expect: () =>
        [isA<DetailMovieInitialState>(), isA<DetailMovieErrorState>()],
  );
}
