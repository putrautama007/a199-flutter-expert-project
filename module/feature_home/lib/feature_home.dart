import 'package:core/core.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:feature_movie/presentation/bloc/movie_list/movie_list_event.dart';
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
                create: (_) => MovieListBloc(
                  getTopRatedMovies: Modular.get<GetTopRatedMovies>(),
                  getPopularMovies: Modular.get<GetPopularMovies>(),
                  getNowPlayingMovies: Modular.get<GetNowPlayingMovies>(),
                )
                  ..add(FetchNowPlayingMovies())
                  ..add(FetchPopularMovies())
                  ..add(FetchTopRatedMovies()),
              ),
            ],
            child: const BottomNavPage(),
          ),
        ),
      ];
}
