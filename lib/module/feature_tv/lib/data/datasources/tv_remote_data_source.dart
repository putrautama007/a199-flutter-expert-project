import 'dart:convert';
import 'package:core/core.dart';
import 'package:feature_tv/data/models/tv_detail_model.dart';
import 'package:feature_tv/data/models/tv_model.dart';
import 'package:feature_tv/data/models/tv_response.dart';
import 'package:feature_tv/external/constants/api_constants.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTvShows();

  Future<List<TvModel>> getPopularTvShows();

  Future<List<TvModel>> getTopRatedTvShows();

  Future<TvDetailModel> getDetailTvShows({
    required String tvId,
  });

  Future<List<TvModel>> getRecommendationTvShows({
    required String tvId,
  });

  Future<List<TvModel>> searchTvShows(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final ApiHelper client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNowPlayingTvShows() async {
    final response =
        await client.get(url: '$baseUrl${ApiConstants.tvOnAir}?$apiKey');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvShows() async {
    final response =
        await client.get(url: '$baseUrl${ApiConstants.tvPopular}?$apiKey');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvShows() async {
    final response =
        await client.get(url: '$baseUrl${ApiConstants.tvTopRated}?$apiKey');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getDetailTvShows({required String tvId}) async {
    final response = await client.get(
        url: '$baseUrl${ApiConstants.detailTv(tvId: tvId)}?$apiKey');

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getRecommendationTvShows({required String tvId}) async {
    final response = await client.get(
        url: '$baseUrl${ApiConstants.recommendationTv(tvId: tvId)}?$apiKey');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvShows(String query) async {
    final response = await client.get(
        url: '$baseUrl${ApiConstants.tvSearch}?$apiKey&query=$query');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
