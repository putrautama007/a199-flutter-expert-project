import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:libraries/libraries.dart';

abstract class TopRatedTvShowState extends Equatable {}

class TopRatedTvShowInitialState extends TopRatedTvShowState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvShowLoadingState extends TopRatedTvShowState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvShowLoadedState extends TopRatedTvShowState {
  final List<TvEntities> tvShowList;

  TopRatedTvShowLoadedState({
    required this.tvShowList,
  });

  @override
  List<Object?> get props => [
    tvShowList,
      ];
}

class TopRatedTvShowErrorState extends TopRatedTvShowState {
  final String message;

  TopRatedTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
