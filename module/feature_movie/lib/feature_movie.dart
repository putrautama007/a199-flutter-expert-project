import 'package:core/core.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:feature_movie/external/route/movie_route.dart';
import 'package:feature_movie/presentation/bloc/popular_movie/popular_cubit.dart';
import 'package:feature_movie/presentation/bloc/search_movie/search_cubit.dart';
import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_cubit.dart';
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
          child: (_, __) => BlocProvider(
            create: (_) => SearchCubit(
              searchMovies: Modular.get<SearchMovies>(),
            ),
            child: const SearchPage(),
          ),
        ),
        ChildRoute(
          MovieRoute.popularMovie,
          child: (_, __) => BlocProvider(
            create: (_) => PopularCubit(
              getPopularMovies: Modular.get<GetPopularMovies>(),
            )..fetchPopularMovies(),
            child: const PopularMoviesPage(),
          ),
        ),
        ChildRoute(
          MovieRoute.topRatedMovie,
          child: (_, __) => BlocProvider(
            create: (_) => TopRatedCubit(
              getTopRatedMovies: Modular.get<GetTopRatedMovies>(),
            )..fetchTopRatedMovies(),
            child: const TopRatedMoviesPage(),
          ),
        ),
      ];
}
