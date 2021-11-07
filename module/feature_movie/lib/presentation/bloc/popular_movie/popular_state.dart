import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class NowPlayingState extends Equatable {}

class NowPlayingInitialState extends NowPlayingState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadingState extends NowPlayingState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoadedState extends NowPlayingState {
  final List<Movie> movieList;

  NowPlayingLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class PopularErrorState extends NowPlayingState {
  final String message;

  PopularErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
