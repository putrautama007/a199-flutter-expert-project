import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class RecommendationMovieState extends Equatable {}

class RecommendationMovieInitialState extends RecommendationMovieState {
  @override
  List<Object?> get props => [];
}

class RecommendationMovieLoadingState extends RecommendationMovieState {
  @override
  List<Object?> get props => [];
}

class RecommendationMovieLoadedState extends RecommendationMovieState {
  final List<Movie> movieList;

  RecommendationMovieLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class RecommendationMovieErrorState extends RecommendationMovieState {
  final String message;

  RecommendationMovieErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
