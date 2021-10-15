import 'package:ditonton/feature/feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/core/util/common/exception.dart';
import '../../../../core/dummy_data/dummy_objects.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl tvLocalDataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    tvLocalDataSourceImpl =
        TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save tv show watchlist', () {
    test(
        'should return success message when insert tv show data to database is success',
        () async {
      /// arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);

      /// act
      final result =
          await tvLocalDataSourceImpl.insertWatchlist(testTvShowTable);

      /// assert
      expect(result, 'Added to Watchlist');
    });

    test(
        'should throw DatabaseException when insert tv show data to database is failed',
        () async {
      /// arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());

      /// act
      final call = tvLocalDataSourceImpl.insertWatchlist(testTvShowTable);

      /// assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove tv show watchlist', () {
    test(
        'should return success message when remove tv show data from database is success',
        () async {
      /// arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);
      /// act
      final result =
          await tvLocalDataSourceImpl.removeWatchlist(testTvShowTable);
      /// assert
      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw DatabaseException when remove tv show data from database is failed',
        () async {
      /// arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());

      /// act
      final call = tvLocalDataSourceImpl.removeWatchlist(testTvShowTable);

      /// assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get tv show Detail By Id', () {
    const tvShowId = 1;

    test('should return Tv Show Detail Table when tv show data is found',
        () async {
      /// arrange
      when(mockDatabaseHelper.getTvShowById(tvShowId))
          .thenAnswer((_) async => testTvShowMap);

      /// act
      final result = await tvLocalDataSourceImpl.getTvShowById(tvShowId);

      /// assert
      expect(result, testTvShowTable);
    });

    test('should return null when tv show data is not found', () async {
      /// arrange
      when(mockDatabaseHelper.getTvShowById(tvShowId))
          .thenAnswer((_) async => null);

      /// act
      final result = await tvLocalDataSourceImpl.getTvShowById(tvShowId);

      /// assert
      expect(result, null);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of TvShowTable from database', () async {
      /// arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowMap]);

      /// act
      final result = await tvLocalDataSourceImpl.getWatchlistTvShows();

      /// assert
      expect(result, [testTvShowTable]);
    });
  });
}
