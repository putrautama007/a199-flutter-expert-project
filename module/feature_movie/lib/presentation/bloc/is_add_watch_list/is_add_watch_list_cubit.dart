import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:feature_movie/presentation/bloc/is_add_watch_list/is_add_watch_list_state.dart';
import 'package:libraries/libraries.dart';

class IsAddWatchlistCubit extends Cubit<IsAddWatchListState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  IsAddWatchlistCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(IsAddWatchListInitialState());

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(IsAddWatchListErrorState());
      },
      (successMessage) async {
        emit(IsAddWatchListAddMovieState());
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(IsAddWatchListErrorState());
      },
      (successMessage) async {
        emit(IsAddWatchListRemoveMovieState());
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    emit(IsAddWatchListLoadingState());
    final result = await getWatchListStatus.execute(id);
    if (result) {
      emit(IsAddWatchListRemoveMovieState());
    } else {
      emit(IsAddWatchListAddMovieState());
    }
  }
}
