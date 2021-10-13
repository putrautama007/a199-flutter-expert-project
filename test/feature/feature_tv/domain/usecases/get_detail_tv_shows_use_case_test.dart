import 'package:dartz/dartz.dart';
import 'package:ditonton/feature/feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/dummy_data/dummy_objects.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late GetDetailTvShowsUseCase getDetailTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getDetailTvShowsUseCase =
        GetDetailTvShowUseCaseImpl(tvRepositories: mockTvRepositories);
  });

  final tvId = "1";

  test('should get tv show detail from the tv repository', () async {
    /// arrange
    when(mockTvRepositories.getDetailTvShows(tvId: tvId))
        .thenAnswer((_) async => Right(testTvShowDetail));

    /// act
    final result = await getDetailTvShowsUseCase.getDetailTvShows(tvId: tvId);

    /// assert
    expect(result, Right(testTvShowDetail));
  });
}
