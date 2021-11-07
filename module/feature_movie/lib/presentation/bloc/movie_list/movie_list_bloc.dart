import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:feature_movie/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:libraries/libraries.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListInitialState());

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is FetchNowPlayingMovies) {
      yield MovieListLoadingState();
      final result = await getNowPlayingMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield MovieListErrorState(message: failure.message);
        },
        (moviesData) async* {
          yield MovieListNowPlayingLoadedState(movieList: moviesData);
        },
      );
    } else if (event is FetchPopularMovies) {
      yield MovieListLoadingState();
      final result = await getPopularMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield MovieListErrorState(message: failure.message);
        },
        (moviesData) async* {
          yield MovieListPopularLoadedState(movieList: moviesData);
        },
      );
    } else {
      yield MovieListLoadingState();
      final result = await getTopRatedMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield MovieListErrorState(message: failure.message);
        },
        (moviesData) async* {
          yield MovieListTopRatedLoadedState(movieList: moviesData);
        },
      );
    }
  }
}
