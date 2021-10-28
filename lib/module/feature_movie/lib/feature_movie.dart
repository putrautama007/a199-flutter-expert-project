import 'package:core/core.dart';
import 'package:feature_movie/presentation/pages/home_movie_page.dart';
import 'package:libraries/libraries.dart';

class FeatureMovie extends Module{
  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      MainRoutes.featureMovie,
      child: (_, __) => const HomeMoviePage(),
    ),
  ];
}