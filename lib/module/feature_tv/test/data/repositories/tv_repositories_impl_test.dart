import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/data/models/episode_model.dart';
import 'package:feature_tv/data/models/season_model.dart';
import 'package:feature_tv/data/models/tv_detail_model.dart';
import 'package:feature_tv/data/models/tv_model.dart';
import 'package:feature_tv/data/repositories/tv_repositories_impl.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late TvRepositoriesImpl tvRepositoriesImpl;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    tvRepositoriesImpl = TvRepositoriesImpl(
      tvRemoteDataSource: mockTvRemoteDataSource,
      tvLocalDataSource: mockTvLocalDataSource,
    );
  });

  const tvShowModel = TvModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 93405,
    overview: "overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 7.9,
    voteCount: 7127,
    originalName: 'original_name',
    firstAirDate: 'firstAirDate',
    originalLanguage: 'ko',
    originCountry: ["KR"],
  );

  const tvShowEntity = TvEntities(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 93405,
    overview: "overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 7.9,
    voteCount: 7127,
    originalName: 'original_name',
    firstAirDate: 'firstAirDate',
    originalLanguage: 'ko',
    originCountry: ["KR"],
  );

  final tvShowModelList = <TvModel>[tvShowModel];
  final tvShowList = <TvEntities>[tvShowEntity];

  group('On The Air Tv Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getNowPlayingTvShows())
          .thenAnswer((_) async => tvShowModelList);

      /// act
      final result = await tvRepositoriesImpl.getNowPlayingTvShows();

      /// assert
      verify(mockTvRemoteDataSource.getNowPlayingTvShows());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(ServerException());

      /// act
      final result = await tvRepositoriesImpl.getNowPlayingTvShows();

      /// assert
      verify(mockTvRemoteDataSource.getNowPlayingTvShows());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result = await tvRepositoriesImpl.getNowPlayingTvShows();

      /// assert
      verify(mockTvRemoteDataSource.getNowPlayingTvShows());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Show', () {
    test('should return tv show list when call to data source is success',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getPopularTvShows())
          .thenAnswer((_) async => tvShowModelList);

      /// act
      final result = await tvRepositoriesImpl.getPopularTvShows();

      /// assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getPopularTvShows())
          .thenThrow(ServerException());

      /// act
      final result = await tvRepositoriesImpl.getPopularTvShows();

      /// assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getPopularTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result = await tvRepositoriesImpl.getPopularTvShows();

      /// assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Show', () {
    test('should return tv show list when call to data source is successful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => tvShowModelList);

      /// act
      final result = await tvRepositoriesImpl.getTopRatedTvShows();

      /// assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());

      /// act
      final result = await tvRepositoriesImpl.getTopRatedTvShows();

      /// assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getTopRatedTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result = await tvRepositoriesImpl.getTopRatedTvShows();

      /// assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Detail', () {
    const tvId = "1";
    const tvShowResponse = TvDetailModel(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1,
      voteCount: 1,
      episodeRunTime: [1],
      numberOfSeasons: 1,
      languages: ["KR"],
      nextEpisodeToAir: EpisodeModel(
        voteCount: 1,
        airDate: '',
        stillPath: '',
        name: '',
        overview: '',
        id: 1,
        episodeNumber: 1,
        voteAverage: 1.0,
        seasonNumber: 1,
        productionCode: '',
      ),
      originCountry: ["KR"],
      seasons: [
        SeasonModel(
          airDate: "airDate",
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1,
        )
      ],
      firstAirDate: '',
      inProduction: false,
      type: '',
      originalName: 'title',
      lastAirDate: '',
      numberOfEpisodes: 1,
      lastEpisodeToAir: EpisodeModel(
        airDate: '',
        episodeNumber: 1,
        id: 1,
        name: "name",
        overview: "overview",
        productionCode: '',
        seasonNumber: 1,
        stillPath: "stillPath",
        voteAverage: 1.0,
        voteCount: 1,
      ),
      name: 'title',
    );

    test(
        'should return tv show detail data when the call to remote data source is successful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getDetailTvShows(tvId: tvId))
          .thenAnswer((_) async => tvShowResponse);

      /// act
      final result = await tvRepositoriesImpl.getDetailTvShows(tvId: tvId);

      /// assert
      verify(mockTvRemoteDataSource.getDetailTvShows(tvId: tvId));
      expect(result, equals(const Right(testTvShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getDetailTvShows(tvId: tvId))
          .thenThrow(ServerException());

      /// act
      final result = await tvRepositoriesImpl.getDetailTvShows(tvId: tvId);

      /// assert
      verify(mockTvRemoteDataSource.getDetailTvShows(tvId: tvId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getDetailTvShows(tvId: tvId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result = await tvRepositoriesImpl.getDetailTvShows(tvId: tvId);

      /// assert
      verify(mockTvRemoteDataSource.getDetailTvShows(tvId: tvId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tvShowList = <TvModel>[];
    const tvId = "1";

    test('should return data tv model list when the call is successful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getRecommendationTvShows(tvId: tvId))
          .thenAnswer((_) async => tvShowList);

      /// act
      final result =
          await tvRepositoriesImpl.getRecommendationTvShows(tvId: tvId);

      /// assert
      verify(mockTvRemoteDataSource.getRecommendationTvShows(tvId: tvId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tvShowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getRecommendationTvShows(tvId: tvId))
          .thenThrow(ServerException());

      /// act
      final result =
          await tvRepositoriesImpl.getRecommendationTvShows(tvId: tvId);

      /// assert
      verify(mockTvRemoteDataSource.getRecommendationTvShows(tvId: tvId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.getRecommendationTvShows(tvId: tvId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result =
          await tvRepositoriesImpl.getRecommendationTvShows(tvId: tvId);

      /// assert
      verify(mockTvRemoteDataSource.getRecommendationTvShows(tvId: tvId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Show', () {
    const tvShowQuery = 'Squid Game';

    test('should return tv show list when call to data source is successful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.searchTvShows(tvShowQuery))
          .thenAnswer((_) async => tvShowModelList);

      /// act
      final result = await tvRepositoriesImpl.searchTvShows(tvShowQuery);

      /// assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.searchTvShows(tvShowQuery))
          .thenThrow(ServerException());

      /// act
      final result = await tvRepositoriesImpl.searchTvShows(tvShowQuery);

      /// assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      /// arrange
      when(mockTvRemoteDataSource.searchTvShows(tvShowQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));

      /// act
      final result = await tvRepositoriesImpl.searchTvShows(tvShowQuery);

      /// assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save tv show watchlist', () {
    test('should return success message when saving successful', () async {
      /// arrange
      when(mockTvLocalDataSource.insertWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      /// act
      final result = await tvRepositoriesImpl.saveWatchlist(testTvShowDetail);

      /// assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      /// arrange
      when(mockTvLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      /// act
      final result = await tvRepositoriesImpl.saveWatchlist(testTvShowDetail);

      /// assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove tv show watchlist', () {
    test('should return success message when remove successful', () async {
      /// arrange
      when(mockTvLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      /// act
      final result = await tvRepositoriesImpl.removeWatchlist(testTvShowDetail);

      /// assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      /// arrange
      when(mockTvLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      /// act
      final result = await tvRepositoriesImpl.removeWatchlist(testTvShowDetail);

      /// assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get tv show watchlist status', () {
    test('should return watch status whether data is found', () async {
      /// arrange
      const tvId = 1;
      when(mockTvLocalDataSource.getTvShowById(tvId))
          .thenAnswer((_) async => null);

      /// act
      final result = await tvRepositoriesImpl.isAddedToWatchlist(tvId);

      /// assert
      expect(result, false);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of tv show', () async {
      /// arrange
      when(mockTvLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);

      /// act
      final result = await tvRepositoriesImpl.getWatchlistTvShows();

      /// assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}
