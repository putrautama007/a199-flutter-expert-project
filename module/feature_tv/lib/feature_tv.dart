import 'package:core/core.dart';
import 'package:feature_tv/external/route/tv_routes.dart';
import 'package:feature_tv/presentation/pages/home_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/popular_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/search_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/top_rated_tv_show_page.dart';
import 'package:feature_tv/presentation/pages/tv_show_detail_page.dart';
import 'package:libraries/libraries.dart';

class FeatureTvShow extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      MainRoutes.featureTv,
      child: (_, __) => const HomeTVShowPage(),
    ),
    ChildRoute(
      TvRoutes.tvShowDetail,
      child: (_, args) => TvShowDetailPage(tvId: args.data),
    ),
    ChildRoute(
      TvRoutes.tvShowSearch,
      child: (_, __) => const SearchTvShowPage(),
    ),
    ChildRoute(
      TvRoutes.tvShowPopular,
      child: (_, __) => const PopularTvShowPage(),
    ),
    ChildRoute(
      TvRoutes.tvShowTopRated,
      child: (_, __) => const TopRatedTvShowPage(),
    ),
  ];
}

