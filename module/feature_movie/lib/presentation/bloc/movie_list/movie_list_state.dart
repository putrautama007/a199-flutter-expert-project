import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class MovieListState extends Equatable {}

class MovieListInitialState extends MovieListState {
  @override
  List<Object?> get props => [];
}

class MovieListLoadingState extends MovieListState {
  @override
  List<Object?> get props => [];
}

class MovieListPopularLoadedState extends MovieListState {
  final List<Movie> movieList;

  MovieListPopularLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class MovieListNowPlayingLoadedState extends MovieListState {
  final List<Movie> movieList;

  MovieListNowPlayingLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class MovieListTopRatedLoadedState extends MovieListState {
  final List<Movie> movieList;

  MovieListTopRatedLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class MovieListErrorState extends MovieListState {
  final String message;

  MovieListErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
