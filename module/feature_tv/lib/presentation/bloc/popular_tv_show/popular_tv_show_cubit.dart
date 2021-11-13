import 'package:feature_tv/domain/usecases/get_popular_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_show/popular_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class PopularCubit extends Cubit<PopularTvShowState> {
  final GetPopularTvShowsUseCase getPopularTvShowsUseCase;

  PopularCubit({
    required this.getPopularTvShowsUseCase,
  }) : super(PopularTvShowInitialState());

  Future<void> fetchPopularTvShow() async {
    emit(PopularTvShowLoadingState());
    final result = await getPopularTvShowsUseCase.getPopularTvShows();
    result.fold(
      (failure) async {
        emit(PopularTvShowErrorState(message: failure.message));
      },
      (tvShowList) async {
        emit(PopularTvShowLoadedState(tvShowList: tvShowList));
      },
    );
  }
}
