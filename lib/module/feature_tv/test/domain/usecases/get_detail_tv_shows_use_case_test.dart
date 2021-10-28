import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetDetailTvShowsUseCase getDetailTvShowsUseCase;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    getDetailTvShowsUseCase =
        GetDetailTvShowUseCaseImpl(tvRepositories: mockTvRepositories);
  });

  const tvId = "1";

  test('should get tv show detail from the tv repository', () async {
    /// arrange
    when(mockTvRepositories.getDetailTvShows(tvId: tvId))
        .thenAnswer((_) async => const Right(testTvShowDetail));

    /// act
    final result = await getDetailTvShowsUseCase.getDetailTvShows(tvId: tvId);

    /// assert
    expect(result, const Right(testTvShowDetail));
  });
}
