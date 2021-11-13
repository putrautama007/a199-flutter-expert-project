import 'package:feature_tv/domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_show/top_rated_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class TopRatedTvShowCubit extends Cubit<TopRatedTvShowState> {
  final GetTopRatedTvShowsUseCase getTopRatedTvShowsUseCase;

  TopRatedTvShowCubit({
    required this.getTopRatedTvShowsUseCase,
  }) : super(TopRatedTvShowInitialState());

  Future<void> fetchTopRatedTvShow() async {
    emit(TopRatedTvShowLoadingState());
    final result = await getTopRatedTvShowsUseCase.getTopRatedTvShows();
    result.fold(
      (failure) async {
        emit(TopRatedTvShowErrorState(message: failure.message));
      },
      (tvShowList) async {
        emit(TopRatedTvShowLoadedState(tvShowList: tvShowList));
      },
    );
  }
}
