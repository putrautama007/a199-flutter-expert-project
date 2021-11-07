import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/presentation/bloc/now_playing_movie/now_playing_state.dart';
import 'package:libraries/libraries.dart';

class NowPlayingCubit extends Cubit<PopularState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingCubit({
    required this.getNowPlayingMovies,
  }) : super(PopularInitialState());

  Future<void> fetchNowPlayingMovies() async {
    emit(PopularLoadingState());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) async {
        emit(NowPlayingErrorState(message: failure.message));
      },
      (moviesData) async {
        emit(PopularLoadedState(movieList: moviesData));
      },
    );
  }
}
