import 'package:ditonton/core/util/db/database_helper.dart';
import 'package:ditonton/feature/feature_movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/feature/feature_movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/feature/feature_movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/feature/feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/feature/feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/feature/feature_tv/domain/repositories/tv_repositories.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvRemoteDataSource,
  TvRepositories,
  TvLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
