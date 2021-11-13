import 'package:feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:feature_tv/presentation/bloc/search_tv_show/search_tv_show_state.dart';
import 'package:libraries/libraries.dart';

class SearchTvShowCubit extends Cubit<SearchTvShowState> {
  final SearchTvShowsUseCase searchTvShowsUseCase;

  SearchTvShowCubit({
    required this.searchTvShowsUseCase,
  }) : super(SearchTvShowInitialState());

  Future<void> fetchTvShowSearch(String query) async {
    emit(SearchTvShowLoadingState());

    final result = await searchTvShowsUseCase.searchTvShows(query);
    result.fold(
      (failure) async {
        emit(SearchTvShowErrorState(message: failure.message));
      },
      (tvShowList) async {
        emit(SearchTvShowLoadedState(tvShowList: tvShowList));
      },
    );
  }
}
