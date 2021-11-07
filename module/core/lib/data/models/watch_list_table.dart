import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';

class WatchListTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const WatchListTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory WatchListTable.fromMovieEntity(MovieDetail movie) => WatchListTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory WatchListTable.fromTvShowEntity(TvDetailEntities tvShow) =>
      WatchListTable(
        id: tvShow.id,
        title: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  factory WatchListTable.fromMap(Map<String, dynamic> map) => WatchListTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toMovieEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  TvEntities toTvShowsEntity() => TvEntities.watchlist(
        id: id,
        originalName: title,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
      ];
}
