import 'data/datasources/tv_local_data_source_test.dart'
    as tv_local_data_source_test;
import 'data/datasources/tv_remote_data_source_test.dart'
    as tv_remote_data_source_test;
import 'data/models/tv_entities_test.dart' as tv_entities_test;
import 'data/models/tv_model_test.dart' as tv_model_test;
import 'data/repositories/tv_repositories_impl_test.dart'
    as tv_repositories_impl_test;
import 'domain/usecases/get_detail_tv_shows_use_case_test.dart'
    as get_detail_tv_shows_use_case_test;
import 'domain/usecases/get_now_playing_tv_shows_use_case_test.dart'
    as get_now_playing_tv_shows_use_case_test;
import 'domain/usecases/get_popular_tv_shows_use_case_test.dart'
    as get_popular_tv_shows_use_case_test;
import 'domain/usecases/get_recommendation_tv_shows_use_case_test.dart'
    as get_recommendation_tv_shows_use_case_test;
import 'domain/usecases/get_top_rated_tv_shows_use_case_test.dart'
    as get_top_rated_tv_shows_use_case_test;
import 'domain/usecases/get_watchlist_status_tv_shows_use_case_test.dart'
    as get_watchlist_status_tv_shows_use_case_test;
import 'domain/usecases/get_watchlist_tv_shows_use_case_test.dart'
    as get_watchlist_tv_shows_use_case_test;
import 'domain/usecases/remove_watchlist_tv_shows_use_case_test.dart'
    as remove_watchlist_tv_shows_use_case_test;
import 'domain/usecases/save_watchlist_tv_shows_use_case_test.dart'
    as save_watchlist_tv_shows_use_case_test;
import 'domain/usecases/search_tv_shows_use_case_test.dart'
    as search_tv_shows_use_case_test;
import 'presentation/bloc/detail_tv_show/detail_tv_show_cubit_test.dart'
    as detail_tv_show_cubit_test;
import 'presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_cubit_test.dart'
    as is_tv_show_add_watch_list_cubit_test;
import 'presentation/bloc/now_playing_tv_show/now_playing_tv_show_cubit_test.dart'
    as now_playing_tv_show_cubit_test;
import 'presentation/bloc/popular_tv_show/popular_tv_show_cubit_test.dart'
    as popular_tv_show_cubit_test;
import 'presentation/bloc/recommendation_tv_show/recommendation_tv_show_cubit_test.dart'
    as recommendation_tv_show_cubit_test;
import 'presentation/bloc/search_tv_show/search_tv_show_cubit_test.dart'
    as search_tv_show_cubit_test;
import 'presentation/bloc/top_rated_tv_show/top_rated_tv_show_cubit_test.dart'
    as top_rated_tv_show_cubit_test;
import 'presentation/bloc/watch_list_tv_show/watch_list_tv_show_cubit_test.dart'
    as watch_list_tv_show_cubit_test;

void main() {
  tv_local_data_source_test.main();
  tv_remote_data_source_test.main();
  tv_entities_test.main();
  tv_model_test.main();
  tv_repositories_impl_test.main();
  get_detail_tv_shows_use_case_test.main();
  get_now_playing_tv_shows_use_case_test.main();
  get_popular_tv_shows_use_case_test.main();
  get_recommendation_tv_shows_use_case_test.main();
  get_top_rated_tv_shows_use_case_test.main();
  get_watchlist_status_tv_shows_use_case_test.main();
  get_watchlist_tv_shows_use_case_test.main();
  remove_watchlist_tv_shows_use_case_test.main();
  save_watchlist_tv_shows_use_case_test.main();
  search_tv_shows_use_case_test.main();
  detail_tv_show_cubit_test.main();
  is_tv_show_add_watch_list_cubit_test.main();
  now_playing_tv_show_cubit_test.main();
  popular_tv_show_cubit_test.main();
  recommendation_tv_show_cubit_test.main();
  search_tv_show_cubit_test.main();
  top_rated_tv_show_cubit_test.main();
  watch_list_tv_show_cubit_test.main();
}
