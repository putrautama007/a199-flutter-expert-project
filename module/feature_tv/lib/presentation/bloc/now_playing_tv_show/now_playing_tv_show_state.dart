import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:libraries/libraries.dart';

abstract class NowPlayingTvShowState extends Equatable {}

class NowPlayingTvShowInitialState extends NowPlayingTvShowState {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowLoadingState extends NowPlayingTvShowState {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowLoadedState extends NowPlayingTvShowState {
  final List<TvEntities> tvShowList;

  NowPlayingTvShowLoadedState({
    required this.tvShowList,
  });

  @override
  List<Object?> get props => [
        tvShowList,
      ];
}

class NowPlayingTvShowErrorState extends NowPlayingTvShowState {
  final String message;

  NowPlayingTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
