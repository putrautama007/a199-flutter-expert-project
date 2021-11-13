import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:libraries/libraries.dart';

abstract class SearchTvShowState extends Equatable {}

class SearchTvShowInitialState extends SearchTvShowState {
  @override
  List<Object?> get props => [];
}

class SearchTvShowLoadingState extends SearchTvShowState {
  @override
  List<Object?> get props => [];
}

class SearchTvShowLoadedState extends SearchTvShowState {
  final List<TvEntities> tvShowList;

  SearchTvShowLoadedState({
    required this.tvShowList,
  });

  @override
  List<Object?> get props => [
    tvShowList,
      ];
}

class SearchTvShowErrorState extends SearchTvShowState {
  final String message;

  SearchTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
