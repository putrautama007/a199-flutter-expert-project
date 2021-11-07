import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class PopularState extends Equatable {}

class PopularInitialState extends PopularState {
  @override
  List<Object?> get props => [];
}

class PopularLoadingState extends PopularState {
  @override
  List<Object?> get props => [];
}

class PopularLoadedState extends PopularState {
  final List<Movie> movieList;

  PopularLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class PopularErrorState extends PopularState {
  final String message;

  PopularErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
