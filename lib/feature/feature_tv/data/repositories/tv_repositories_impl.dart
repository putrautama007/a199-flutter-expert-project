import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/core/util/common/exception.dart';
import 'package:ditonton/core/util/common/failure.dart';
import 'package:ditonton/feature/feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';

class TvRepositoriesImpl implements TvRepositories {
  final TvRemoteDataSource tvRemoteDataSource;

  TvRepositoriesImpl({
    required this.tvRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<TvEntities>>> getNowPlayingTvShows() async {
    try {
      final result = await tvRemoteDataSource.getNowPlayingTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getPopularTvShows() async {
    try {
      final result = await tvRemoteDataSource.getPopularTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvShows() async {
    try {
      final result = await tvRemoteDataSource.getTopRatedTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
