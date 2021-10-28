import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:feature_tv/domain/entities/tv_detail_entities.dart';
import 'package:feature_tv/domain/entities/tv_entities.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';

class TvRepositoriesImpl implements TvRepositories {
  final TvRemoteDataSource tvRemoteDataSource;
  final TvLocalDataSource tvLocalDataSource;

  TvRepositoriesImpl({
    required this.tvRemoteDataSource,
    required this.tvLocalDataSource,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getNowPlayingTvShows() async {
    try {
      final result = await tvRemoteDataSource.getNowPlayingTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getPopularTvShows() async {
    try {
      final result = await tvRemoteDataSource.getPopularTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvShows() async {
    try {
      final result = await tvRemoteDataSource.getTopRatedTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetailEntities>> getDetailTvShows({
    required String tvId,
  }) async {
    try {
      final result = await tvRemoteDataSource.getDetailTvShows(
        tvId: tvId,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getRecommendationTvShows(
      {required String tvId}) async {
    try {
      final result = await tvRemoteDataSource.getRecommendationTvShows(
        tvId: tvId,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getWatchlistTvShows() async {
    final result = await tvLocalDataSource.getWatchlistTvShows();
    return Right(result.map((data) => data.toTvShowsEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await tvLocalDataSource.getTvShowById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvDetailEntities tvShow) async {
    try {
      final result = await tvLocalDataSource
          .removeWatchlist(WatchListTable.fromTvShowEntity(tvShow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetailEntities tvShow) async {
    try {
      final result = await tvLocalDataSource
          .insertWatchlist(WatchListTable.fromTvShowEntity(tvShow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> searchTvShows(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTvShows(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
