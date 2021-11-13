import 'package:feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/detail_tv_show/detail_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class DetailTVShowCubit extends Cubit<DetailTvShowState> {
  final GetDetailTvShowsUseCase getDetailTvShowsUseCase;

  DetailTVShowCubit({
    required this.getDetailTvShowsUseCase,
  }) : super(DetailTvShowInitialState());

  Future<void> fetchTvShowDetail(String id) async {
    emit(DetailTvShowInitialState());
    final detailResult =
        await getDetailTvShowsUseCase.getDetailTvShows(tvId: id);
    detailResult.fold(
      (failure) async {
        emit(DetailTvShowErrorState(message: failure.message));
      },
      (tvDetailEntities) async {
        emit(DetailTvShowLoadedState(tvDetailEntities: tvDetailEntities));
      },
    );
  }
}
