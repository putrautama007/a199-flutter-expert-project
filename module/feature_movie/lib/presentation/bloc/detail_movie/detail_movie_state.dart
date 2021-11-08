import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:libraries/libraries.dart';

abstract class DetailMovieState extends Equatable {}

class DetailMovieInitialState extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

class DetailMovieLoadingState extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

class DetailMovieLoadedState extends DetailMovieState {
  final MovieDetail movieDetail;

  DetailMovieLoadedState({
    required this.movieDetail,
  });

  @override
  List<Object?> get props => [
        movieDetail,
      ];
}

class DetailMovieErrorState extends DetailMovieState {
  final String message;

  DetailMovieErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
