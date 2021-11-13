import 'package:feature_tv/domain/usecases/get_now_playing_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/now_playing_tv_show/now_playing_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class NowPlayingTvShowCubit extends Cubit<NowPlayingTvShowState> {
  final GetNowPlayingTvShowsUseCase getNowPlayingTvShowsUseCase;

  NowPlayingTvShowCubit({
    required this.getNowPlayingTvShowsUseCase,
  }) : super(NowPlayingTvShowInitialState());

  Future<void> fetchNowPlayingTvShow() async {
    emit(NowPlayingTvShowLoadingState());
    final result = await getNowPlayingTvShowsUseCase.getNowPlayingTvShows();
    result.fold(
      (failure) async {
        emit(NowPlayingTvShowErrorState(message: failure.message));
      },
      (tvShowList) async {
        emit(NowPlayingTvShowLoadedState(tvShowList: tvShowList));
      },
    );
  }
}
