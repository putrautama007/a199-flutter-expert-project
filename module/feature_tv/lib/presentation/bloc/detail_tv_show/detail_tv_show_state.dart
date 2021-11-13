import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:libraries/libraries.dart';

abstract class DetailTvShowState extends Equatable {}

class DetailTvShowInitialState extends DetailTvShowState {
  @override
  List<Object?> get props => [];
}

class DetailTvShowLoadingState extends DetailTvShowState {
  @override
  List<Object?> get props => [];
}

class DetailTvShowLoadedState extends DetailTvShowState {
  final TvDetailEntities tvDetailEntities;

  DetailTvShowLoadedState({
    required this.tvDetailEntities,
  });

  @override
  List<Object?> get props => [
    tvDetailEntities,
      ];
}

class DetailTvShowErrorState extends DetailTvShowState {
  final String message;

  DetailTvShowErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
