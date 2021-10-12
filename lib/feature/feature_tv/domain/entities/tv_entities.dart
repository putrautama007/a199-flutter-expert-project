import 'package:equatable/equatable.dart';

class TvEntities extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final List<String>? originCountry;
  final int? id;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  TvEntities({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.originCountry,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  TvEntities.watchlist({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.originCountry,
    required this.id,
    this.originalLanguage,
    required this.originalName,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        originalLanguage,
        id,
        originCountry,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
