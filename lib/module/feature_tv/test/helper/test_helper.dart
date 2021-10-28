
import 'package:core/util/db/database_helper.dart';
import 'package:feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,
  TvRemoteDataSource,
  TvRepositories,
  TvLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
