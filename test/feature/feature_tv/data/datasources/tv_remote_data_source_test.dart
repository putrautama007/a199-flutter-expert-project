import 'dart:convert';
import 'package:ditonton/core/util/constant/api_constants.dart';
import 'package:ditonton/feature/feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/feature/feature_tv/data/models/tv_detail_model.dart';
import 'package:ditonton/feature/feature_tv/data/models/tv_response.dart';
import 'package:ditonton/feature/feature_tv/external/constants/api_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/core/util/common/exception.dart';
import '../../../../core/helpers/test_helper.mocks.dart';
import '../../../../core/json_reader.dart';
import 'package:http/http.dart' as http;

void main() {
  late TvRemoteDataSourceImpl tvRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    tvRemoteDataSourceImpl = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air Tv Shows', () {
    final tvShowList = TvResponse.fromJson(
            json.decode(readJson('core/dummy_data/on_the_air.json')))
        .tvList;

    test('should return list of tv show model when the response code is 200',
        () async {
      /// arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl${ApiConstants.tvOnAir}?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('core/dummy_data/on_the_air.json'), 200));

      /// act
      final result = await tvRemoteDataSourceImpl.getNowPlayingTvShows();

      /// assert
      expect(result, equals(tvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      /// arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl${ApiConstants.tvOnAir}?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      /// act
      final call = tvRemoteDataSourceImpl.getNowPlayingTvShows();

      /// assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Show', () {
    final tvShowList = TvResponse.fromJson(
            json.decode(readJson('core/dummy_data/tv_show_popular.json')))
        .tvList;

    test('should return list of tv show model when response is success (200)',
        () async {
      /// arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl${ApiConstants.tvPopular}?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('core/dummy_data/tv_show_popular.json'), 200));

      /// act
      final result = await tvRemoteDataSourceImpl.getPopularTvShows();

      /// assert
      expect(result, tvShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      /// arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl${ApiConstants.tvPopular}?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      /// act
      final call = tvRemoteDataSourceImpl.getPopularTvShows();

      /// assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Show', () {
    final tvShowList = TvResponse.fromJson(
            json.decode(readJson('core/dummy_data/tv_show_top_rated.json')))
        .tvList;

    test('should return list of tv show model when response code is 200 ',
        () async {
      /// arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl${ApiConstants.tvTopRated}?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('core/dummy_data/tv_show_top_rated.json'), 200));

      /// act
      final result = await tvRemoteDataSourceImpl.getTopRatedTvShows();

      /// assert
      expect(result, tvShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      /// arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl${ApiConstants.tvTopRated}?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      /// act
      final call = tvRemoteDataSourceImpl.getTopRatedTvShows();

      /// assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    final tvShowId = "93405";
    final tvShowDetail = TvDetailModel.fromJson(
        json.decode(readJson('core/dummy_data/tv_show_detail.json')));

    test('should return tv show detail when the response code is 200',
        () async {
      /// arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl${ApiConstants.detailTv(tvId: tvShowId)}?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('core/dummy_data/tv_show_detail.json'), 200));

      /// act
      final result =
          await tvRemoteDataSourceImpl.getDetailTvShows(tvId: tvShowId);

      /// assert
      expect(result, equals(tvShowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      /// arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl${ApiConstants.detailTv(tvId: tvShowId)}?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      /// act
      final call = tvRemoteDataSourceImpl.getDetailTvShows(tvId: tvShowId);

      /// assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final tvShowList = TvResponse.fromJson(json
            .decode(readJson('core/dummy_data/tv_show_recommendations.json')))
        .tvList;
    final tvShowId = "93405";

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      /// arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl${ApiConstants.recommendationTv(tvId: tvShowId)}?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('core/dummy_data/tv_show_recommendations.json'), 200));

      /// act
      final result =
          await tvRemoteDataSourceImpl.getRecommendationTvShows(tvId: tvShowId);

      /// assert
      expect(result, equals(tvShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      /// arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl${ApiConstants.recommendationTv(tvId: tvShowId)}?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      /// act
      final call =
          tvRemoteDataSourceImpl.getRecommendationTvShows(tvId: tvShowId);

      /// assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv show', () {
    final tvShowSearchResult = TvResponse.fromJson(
            json.decode(readJson('core/dummy_data/tv_show_search.json')))
        .tvList;
    final tQuery = 'Squid Game';

    test('should return list of tv show when response code is 200', () async {
      /// arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl${ApiConstants.tvSearch}?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('core/dummy_data/tv_show_search.json'), 200));

      /// act
      final result = await tvRemoteDataSourceImpl.searchTvShows(tQuery);

      /// assert
      expect(result, tvShowSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      /// arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl${ApiConstants.tvSearch}?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      /// act
      final call = tvRemoteDataSourceImpl.searchTvShows(tQuery);

      /// assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
