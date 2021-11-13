import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:libraries/libraries.dart';

abstract class WatchListTvShowState extends Equatable {}

class WatchListTvShowInitialState extends WatchListTvShowState {
  @override
  List<Object?> get props => [];
}

class WatchListTvShowLoadingState extends WatchListTvShowState {
  @override
  List<Object?> get props => [];
}

class WatchListTvShowLoadedState extends WatchListTvShowState {
  final List<TvEntities> tvShowList;

  WatchListTvShowLoadedState({
    required this.tvShowList,
  });

  @override
  List<Object?> get props => [
        tvShowList,
      ];
}

class WatchListTvShowErrorState extends WatchListTvShowState {
  final String message;

  WatchListTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
