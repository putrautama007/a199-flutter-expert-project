import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:feature_movie/presentation/bloc/search_movie/search_state.dart';
import 'package:libraries/libraries.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMovies searchMovies;

  SearchCubit({
    required this.searchMovies,
  }) : super(SearchInitialState());

  Future<void> fetchMovieSearch(String query) async {
    emit(SearchLoadingState());

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) async {
        emit(SearchErrorState(message: failure.message));
      },
      (data) async {
        emit(SearchLoadedState(movieList: data));
      },
    );
  }
}
