import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:libraries/libraries.dart';

abstract class RecommendationTvShowState extends Equatable {}

class RecommendationTvShowInitialState extends RecommendationTvShowState {
  @override
  List<Object?> get props => [];
}

class RecommendationTvShowLoadingState extends RecommendationTvShowState {
  @override
  List<Object?> get props => [];
}

class RecommendationTvShowLoadedState extends RecommendationTvShowState {
  final List<TvEntities> tvShowList;

  RecommendationTvShowLoadedState({
    required this.tvShowList,
  });

  @override
  List<Object?> get props => [
        tvShowList,
      ];
}

class RecommendationTvShowErrorState extends RecommendationTvShowState {
  final String message;

  RecommendationTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
