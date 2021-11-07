import 'package:feature_movie/domain/entities/movie.dart';
import 'package:libraries/libraries.dart';

abstract class SearchState extends Equatable {}

class SearchInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<Movie> movieList;

  SearchLoadedState({
    required this.movieList,
  });

  @override
  List<Object?> get props => [
        movieList,
      ];
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
