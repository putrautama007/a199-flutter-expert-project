import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_state.dart';
import 'package:libraries/libraries.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedCubit({
    required this.getTopRatedMovies,
  }) : super(TopRatedInitialState());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedLoadingState());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) async {
        emit(TopRatedErrorState(message: failure.message));
      },
      (moviesData) async {
        emit(TopRatedLoadedState(movieList: moviesData));
      },
    );
  }
}
