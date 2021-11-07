import 'package:libraries/libraries.dart';

abstract class MovieListEvent extends Equatable {}

class FetchNowPlayingMovies extends MovieListEvent {
  @override
  List<Object?> get props => [];
}

class FetchPopularMovies extends MovieListEvent {
  @override
  List<Object?> get props => [];
}

class FetchTopRatedMovies extends MovieListEvent {
  @override
  List<Object?> get props => [];
}
