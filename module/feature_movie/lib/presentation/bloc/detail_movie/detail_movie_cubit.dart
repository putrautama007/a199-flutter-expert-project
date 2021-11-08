import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/presentation/bloc/detail_movie/detail_movie_state.dart';
import 'package:libraries/libraries.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final GetMovieDetail getMovieDetail;

  DetailMovieCubit({
    required this.getMovieDetail,
  }) : super(DetailMovieInitialState());

  Future<void> fetchMovieDetail(int id) async {
    emit(DetailMovieInitialState());
    final detailResult = await getMovieDetail.execute(id);
    detailResult.fold(
      (failure) async {
        emit(DetailMovieErrorState(message: failure.message));
      },
      (movie) async {
        emit(DetailMovieLoadedState(movieDetail: movie));
      },
    );
  }
}
