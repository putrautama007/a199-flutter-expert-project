import 'package:feature_tv/domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_show/recommendation_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class RecommendationTvShowCubit extends Cubit<RecommendationTvShowState> {
  final GetRecommendationTvShowsUseCase getRecommendationTvShowsUseCase;

  RecommendationTvShowCubit({
    required this.getRecommendationTvShowsUseCase,
  }) : super(RecommendationTvShowInitialState());

  Future<void> fetchRecommendationTvShow(String id) async {
    emit(RecommendationTvShowLoadingState());
    final recommendationResult = await getRecommendationTvShowsUseCase
        .getRecommendationTvShows(tvId: id);
    recommendationResult.fold(
      (failure) async {
        emit(RecommendationTvShowErrorState(message: failure.message));
      },
      (tvShowList) async {
        emit(RecommendationTvShowLoadedState(tvShowList: tvShowList));
      },
    );
  }
}
