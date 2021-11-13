import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:libraries/libraries.dart';

abstract class PopularTvShowState extends Equatable {}

class PopularTvShowInitialState extends PopularTvShowState {
  @override
  List<Object?> get props => [];
}

class PopularTvShowLoadingState extends PopularTvShowState {
  @override
  List<Object?> get props => [];
}

class PopularTvShowLoadedState extends PopularTvShowState {
  final List<TvEntities> tvShowList;

  PopularTvShowLoadedState({
    required this.tvShowList,
  });

  @override
  List<Object?> get props => [
    tvShowList,
      ];
}

class PopularTvShowErrorState extends PopularTvShowState {
  final String message;

  PopularTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
