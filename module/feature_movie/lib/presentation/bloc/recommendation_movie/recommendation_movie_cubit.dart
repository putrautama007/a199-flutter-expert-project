import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:feature_movie/presentation/bloc/recommendation_movie/recommendation_movie_state.dart';
import 'package:libraries/libraries.dart';

class RecommendationMovieCubit extends Cubit<RecommendationMovieState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendationMovieCubit({
    required this.getMovieRecommendations,
  }) : super(RecommendationMovieInitialState());

  Future<void> fetchRecommendationMovie(int id) async {
    emit(RecommendationMovieLoadingState());
    final recommendationResult = await getMovieRecommendations.execute(id);
    recommendationResult.fold(
      (failure) async {
        emit(RecommendationMovieErrorState(message: failure.message));
      },
      (movies) async {
        emit(RecommendationMovieLoadedState(movieList: movies));
      },
    );
  }
}
