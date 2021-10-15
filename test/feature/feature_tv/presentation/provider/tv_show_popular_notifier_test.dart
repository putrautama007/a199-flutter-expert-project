import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/core/util/common/state_enum.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:ditonton/feature/feature_tv/presentation/provider/tv_show_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import 'tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShowsUseCase])
void main() {
  late MockGetPopularTvShowsUseCase mockGetPopularTvShowsUseCase;
  late TvShowPopularNotifier tvShowPopularNotifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvShowsUseCase = MockGetPopularTvShowsUseCase();
    tvShowPopularNotifier = TvShowPopularNotifier(
      getPopularTvShowsUseCase: mockGetPopularTvShowsUseCase,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when use case is called', () async {
    /// arrange
    when(mockGetPopularTvShowsUseCase.getPopularTvShows())
        .thenAnswer((_) async => Right(testTvShowList));

    /// act
    tvShowPopularNotifier.fetchPopularTvShows();

    /// assert
    expect(tvShowPopularNotifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    /// arrange
    when(mockGetPopularTvShowsUseCase.getPopularTvShows())
        .thenAnswer((_) async => Right(testTvShowList));

    /// act
    await tvShowPopularNotifier.fetchPopularTvShows();

    /// assert
    expect(tvShowPopularNotifier.state, RequestState.loaded);
    expect(tvShowPopularNotifier.tvShow, testTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    /// arrange
    when(mockGetPopularTvShowsUseCase.getPopularTvShows())
        .thenAnswer((_) async => Left(const ServerFailure('Server Failure')));

    /// act
    await tvShowPopularNotifier.fetchPopularTvShows();

    /// assert
    expect(tvShowPopularNotifier.state, RequestState.error);
    expect(tvShowPopularNotifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
