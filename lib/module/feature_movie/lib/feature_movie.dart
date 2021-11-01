import 'package:core/core.dart';
import 'package:feature_movie/external/route/movie_route.dart';
import 'package:feature_movie/presentation/pages/home_movie_page.dart';
import 'package:feature_movie/presentation/pages/movie_detail_page.dart';
import 'package:feature_movie/presentation/pages/popular_movies_page.dart';
import 'package:feature_movie/presentation/pages/search_page.dart';
import 'package:feature_movie/presentation/pages/top_rated_movies_page.dart';
import 'package:libraries/libraries.dart';

class FeatureMovie extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          MainRoutes.featureMovie,
          child: (_, __) => const HomeMoviePage(),
        ),
        ChildRoute(
          MovieRoute.detailMovie,
          child: (_, args) => MovieDetailPage(id: args.data),
        ),
        ChildRoute(
          MovieRoute.searchMovie,
          child: (_, __) => const SearchPage(),
        ),
        ChildRoute(
          MovieRoute.popularMovie,
          child: (_, __) => const PopularMoviesPage(),
        ),
        ChildRoute(
          MovieRoute.topRatedMovie,
          child: (_, __) => const TopRatedMoviesPage(),
        ),
      ];
}
