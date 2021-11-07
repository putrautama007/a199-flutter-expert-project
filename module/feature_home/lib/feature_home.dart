import 'package:core/core.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/presentation/bloc/now_playing_movie/now_playing_cubit.dart';
import 'package:feature_movie/presentation/bloc/popular_movie/popular_cubit.dart';
import 'package:feature_movie/presentation/bloc/top_rated_movie/top_rated_cubit.dart';
import 'package:feature_movie/presentation/bloc/watch_list/watch_list_movie_cubit.dart';
import 'package:libraries/libraries.dart';
import 'presentation/pages/bottom_nav_page.dart';

class FeatureHome extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          MainRoutes.home,
          child: (_, __) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => BottomNavBloc(initialState: 0),
              ),
              BlocProvider(
                create: (_) => NowPlayingCubit(
                  getNowPlayingMovies: Modular.get<GetNowPlayingMovies>(),
                )..fetchNowPlayingMovies(),
              ),
              BlocProvider(
                create: (_) => PopularCubit(
                  getPopularMovies: Modular.get<GetPopularMovies>(),
                )..fetchPopularMovies(),
              ),
              BlocProvider(
                create: (_) => TopRatedCubit(
                  getTopRatedMovies: Modular.get<GetTopRatedMovies>(),
                )..fetchTopRatedMovies(),
              ),
              BlocProvider(
                create: (_) => WatchListMovieCubit(
                  getWatchlistMovies: Modular.get<GetWatchlistMovies>(),
                )..fetchWatchlistMovies(),
              ),
            ],
            child: const BottomNavPage(),
          ),
        ),
      ];
}
