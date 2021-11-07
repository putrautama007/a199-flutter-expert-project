
import 'package:core/core.dart';
import 'package:core/util/db/database_helper.dart';
import 'package:feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:feature_tv/domain/repositories/tv_repositories.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,
  TvRemoteDataSource,
  TvRepositories,
  TvLocalDataSource,
  ApiHelper,
])
void main() {}
