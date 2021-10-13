import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvShowsUseCase getNowPlayingTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getNowPlayingTvShowsUseCase =
        GetNowPlayingTvShowsUseCaseImpl(tvRepositories: mockTvRepositories);
  });

  final tvShows = <TvEntities>[];

  test('should get list of tv shows from the tv repository', () async {
    /// arrange
    when(mockTvRepositories.getNowPlayingTvShows())
        .thenAnswer((_) async => Right(tvShows));

    /// act
    final result = await getNowPlayingTvShowsUseCase.getNowPlayingTvShows();

    /// assert
    expect(result, Right(tvShows));
  });
}
