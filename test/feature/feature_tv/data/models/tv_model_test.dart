import 'dart:convert';

import 'package:ditonton/feature/feature_tv/data/models/tv_model.dart';
import 'package:ditonton/feature/feature_tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/json_reader.dart';

void main() {
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
  const tShowResponseModel =
      TvResponse(tvList: <TvModel>[tvShowModel]);
  group('fromJson', () {
    test('should return a valid tv show model from JSON', () async {
      /// arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('core/dummy_data/tv_show_popular.json'));
      /// act
      final result = TvResponse.fromJson(jsonMap);
      /// assert
      expect(result, tShowResponseModel);
    });
  });
}
