import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/presentation/bloc/watch_list/watch_list_movie_state.dart';
import 'package:libraries/libraries.dart';

class WatchListMovieCubit extends Cubit<WatchListMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchListMovieCubit({
    required this.getWatchlistMovies,
  }) : super(WatchListInitialState());

  Future<void> fetchWatchlistMovies() async {
    emit(WatchListLoadingState());

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) async {
        emit(WatchListErrorState(message: failure.message));
      },
      (moviesData) async {
        emit(WatchListLoadedState(movieList: moviesData));
      },
    );
  }
}
