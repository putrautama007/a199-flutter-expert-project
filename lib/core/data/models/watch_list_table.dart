import 'package:ditonton/feature/feature_movie/domain/entities/movie.dart';
import 'package:ditonton/feature/feature_movie/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class WatchListTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  WatchListTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory WatchListTable.fromEntity(MovieDetail movie) => WatchListTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
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

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
