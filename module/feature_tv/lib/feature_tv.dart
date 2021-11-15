import 'package:core/core.dart';
import 'package:feature_tv/domain/usecases/get_detail_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart';
import 'package:feature_tv/domain/usecases/search_tv_shows_use_case.dart';
import 'package:feature_tv/external/route/tv_routes.dart';
import 'package:feature_tv/presentation/bloc/detail_tv_show/detail_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_cubit.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_show/popular_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_show/recommendation_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/search_tv_show/search_tv_show_cubit.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_show/top_rated_tv_show_cubit.dart';
import 'package:feature_tv/presentation/pages/home_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/popular_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/search_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/top_rated_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/tv_show_detail_page.dart';
import 'package:libraries/libraries.dart';

import 'domain/usecases/get_popular_tv_shows_use_case.dart';
import 'domain/usecases/get_recommendation_tv_shows_use_case.dart';
import 'domain/usecases/get_top_rated_tv_shows_use_case.dart';
import 'domain/usecases/get_watchlist_status_tv_shows_use_case.dart';

class FeatureTvShow extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          MainRoutes.featureTv,
          child: (_, __) => const HomeTVShowPage(),
        ),
        ChildRoute(
          TvRoutes.tvShowDetail,
          child: (_, args) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => DetailTVShowCubit(
                  getDetailTvShowsUseCase:
                      Modular.get<GetDetailTvShowsUseCase>(),
                )..fetchTvShowDetail(args.data),
              ),
              BlocProvider(
                create: (_) => RecommendationTvShowCubit(
                  getRecommendationTvShowsUseCase:
                      Modular.get<GetRecommendationTvShowsUseCase>(),
                )..fetchRecommendationTvShow(args.data),
              ),
              BlocProvider(
                create: (_) => IsTvShowAddWatchlistCubit(
                  getWatchListStatusTvShowsUseCase:
                      Modular.get<GetWatchListStatusTvShowsUseCase>(),
                  removeWatchListTvShowsUseCase:
                      Modular.get<RemoveWatchListTvShowsUseCase>(),
                  saveWatchListTvShowsUseCase:
                      Modular.get<SaveWatchListTvShowsUseCase>(),
                )..loadWatchlistStatus(args.data),
              ),
            ],
            child: TvShowDetailPage(tvId: args.data),
          ),
        ),
        ChildRoute(
          TvRoutes.tvShowSearch,
          child: (_, __) => BlocProvider(
            create: (_) => SearchTvShowCubit(
              searchTvShowsUseCase: Modular.get<SearchTvShowsUseCase>(),
            ),
            child: const SearchTvShowPage(),
          ),
        ),
        ChildRoute(
          TvRoutes.tvShowPopular,
          child: (_, __) => BlocProvider(
            create: (_) => PopularTvShowCubit(
              getPopularTvShowsUseCase: Modular.get<GetPopularTvShowsUseCase>(),
            )..fetchPopularTvShow(),
            child: const PopularTvShowPage(),
          ),
        ),
        ChildRoute(
          TvRoutes.tvShowTopRated,
          child: (_, __) => BlocProvider(
            create: (_) => TopRatedTvShowCubit(
              getTopRatedTvShowsUseCase:
                  Modular.get<GetTopRatedTvShowsUseCase>(),
            )..fetchTopRatedTvShow(),
            child: const TopRatedTvShowPage(),
          ),
        ),
      ];
}
