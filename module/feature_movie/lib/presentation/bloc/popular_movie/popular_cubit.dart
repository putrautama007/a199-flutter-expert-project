import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/presentation/bloc/popular_movie/popular_state.dart';
import 'package:libraries/libraries.dart';

class PopularCubit extends Cubit<PopularState> {
  final GetPopularMovies getPopularMovies;

  PopularCubit({
    required this.getPopularMovies,
  }) : super(PopularInitialState());

  Future<void> fetchPopularMovies() async {
    emit(PopularLoadingState());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) async {
        emit(PopularErrorState(message: failure.message));
      },
      (moviesData) async {
        emit(PopularLoadedState(movieList: moviesData));
      },
    );
  }
}