import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class WatchListMovieState extends Equatable {}

class WatchListInitialState extends WatchListMovieState {
  @override
  List<Object?> get props => [];
}

class WatchListLoadingState extends WatchListMovieState {
  @override
  List<Object?> get props => [];
}

class WatchListLoadedState extends WatchListMovieState {
  final List<Movie> movieList;

  WatchListLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class WatchListErrorState extends WatchListMovieState {
  final String message;

  WatchListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
