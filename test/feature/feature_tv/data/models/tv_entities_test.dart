import 'package:ditonton/feature/feature_tv/data/models/tv_model.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:flutter_test/flutter_test.dart';

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

  test('should be a subclass of tv show entity', () async {
    final result = tvShowModel.toEntity();
    expect(result, tvShowEntity);
  });
}
