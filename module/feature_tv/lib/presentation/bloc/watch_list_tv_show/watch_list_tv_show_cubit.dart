import 'package:feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/watch_list_tv_show/watch_list_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class WatchListTvShowCubit extends Cubit<WatchListTvShowState> {
  final GetWatchListTvShowsUseCase getWatchListTvShowsUseCase;

  WatchListTvShowCubit({
    required this.getWatchListTvShowsUseCase,
  }) : super(WatchListTvShowInitialState());

  Future<void> fetchWatchlistTvShow() async {
    emit(WatchListTvShowLoadingState());

    final result = await getWatchListTvShowsUseCase.getWatchlistTvShows();
    result.fold(
      (failure) async {
        emit(WatchListTvShowErrorState(message: failure.message));
      },
      (tvShowList) async {
        emit(WatchListTvShowLoadedState(tvShowList: tvShowList));
      },
    );
  }
}
