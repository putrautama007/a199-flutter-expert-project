import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetPopularTvShowsUseCase getPopularTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getPopularTvShowsUseCase = GetPopularTvShowsUseCaseImpl(
      tvRepositories: mockTvRepositories,
    );
  });

  final tvShows = <TvEntities>[];

  test(
      'should get list of tv shows from the tv repository when execute function is called',
          () async {
        /// arrange
        when(mockTvRepositories.getPopularTvShows())
            .thenAnswer((_) async => Right(tvShows));

        /// act
        final result = await getPopularTvShowsUseCase.getPopularTvShows();

        /// assert
        expect(result, Right(tvShows));
      });
}
