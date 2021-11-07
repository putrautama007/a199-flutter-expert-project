import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class TopRatedState extends Equatable {}

class TopRatedInitialState extends TopRatedState {
  @override
  List<Object?> get props => [];
}

class TopRatedLoadingState extends TopRatedState {
  @override
  List<Object?> get props => [];
}

class TopRatedLoadedState extends TopRatedState {
  final List<Movie> movieList;

  TopRatedLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class TopRatedErrorState extends TopRatedState {
  final String message;

  TopRatedErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
