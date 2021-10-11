import 'dart:convert';

import 'package:ditonton/core/util/common/exception.dart';
import 'package:ditonton/core/util/constant/api_constants.dart';
import 'package:ditonton/feature/feature_tv/data/models/tv_model.dart';
import 'package:ditonton/feature/feature_tv/data/models/tv_response.dart';
import 'package:ditonton/feature/feature_tv/external/constants/api_constants.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTvShows();

  Future<List<TvModel>> getPopularTvShows();

  Future<List<TvModel>> getTopRatedTvShows();
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNowPlayingTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl${ApiConstants.tvOnAir}?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvShows() async {
    final response = await client
        .get(Uri.parse('$baseUrl${ApiConstants.tvPopular}?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvShows() async {
    final response = await client
        .get(Uri.parse('$baseUrl${ApiConstants.tvTopRated}?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
