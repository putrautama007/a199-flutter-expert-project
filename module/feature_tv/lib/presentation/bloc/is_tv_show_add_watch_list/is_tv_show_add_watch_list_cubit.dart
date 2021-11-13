import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_state.dart';
import 'package:libraries/libraries.dart';

class IsTvShowAddWatchlistCubit extends Cubit<IsTvShowAddWatchListState> {
  final GetWatchListStatusTvShowsUseCase getWatchListStatusTvShowsUseCase;
  final SaveWatchListTvShowsUseCase saveWatchListTvShowsUseCase;
  final RemoveWatchListTvShowsUseCase removeWatchListTvShowsUseCase;

  IsTvShowAddWatchlistCubit({
    required this.getWatchListStatusTvShowsUseCase,
    required this.saveWatchListTvShowsUseCase,
    required this.removeWatchListTvShowsUseCase,
  }) : super(IsTvShowAddWatchListInitialState());

  Future<void> addWatchlist(TvDetailEntities tvDetailEntities) async {
    final result =
        await saveWatchListTvShowsUseCase.saveWatchlist(tvDetailEntities);

    await result.fold(
      (failure) async {
        emit(IsTvShowAddWatchListErrorState());
      },
      (successMessage) async {
        emit(IsTvShowAddWatchListAddMovieState());
      },
    );

    await loadWatchlistStatus(tvDetailEntities.id);
  }

  Future<void> removeFromWatchlist(TvDetailEntities tvDetailEntities) async {
    final result =
        await removeWatchListTvShowsUseCase.removeWatchlist(tvDetailEntities);

    await result.fold(
      (failure) async {
        emit(IsTvShowAddWatchListErrorState());
      },
      (successMessage) async {
        emit(IsTvShowAddWatchListRemoveMovieState());
      },
    );

    await loadWatchlistStatus(tvDetailEntities.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    emit(IsTvShowAddWatchListLoadingState());
    final result =
        await getWatchListStatusTvShowsUseCase.isAddedToWatchlist(id);
    if (result) {
      emit(IsTvShowAddWatchListRemoveMovieState());
    } else {
      emit(IsTvShowAddWatchListAddMovieState());
    }
  }
}
