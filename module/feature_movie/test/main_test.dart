import 'data/datasources/movie_local_data_source_test.dart'
    as movie_local_data_source_test;
import 'data/datasources/movie_remote_data_source_test.dart'
    as movie_remote_data_source_test;
import 'domain/usecases/get_movie_detail_test.dart' as get_movie_detail_test;
import 'domain/usecases/get_movie_recommendations_test.dart'
    as get_movie_recommendations_test;
import 'domain/usecases/get_now_playing_movies_test.dart'
    as get_now_playing_movies_test;
import 'domain/usecases/get_popular_movies_test.dart'
    as get_popular_movies_test;
import 'domain/usecases/get_top_rated_movies_test.dart'
    as get_top_rated_movies_test;
import 'domain/usecases/get_watchlist_movies_test.dart'
    as get_watchlist_movies_test;
import 'domain/usecases/get_watchlist_status_test.dart'
    as get_watchlist_status_test;
import 'domain/usecases/remove_watchlist_test.dart' as remove_watchlist_test;
import 'domain/usecases/save_watchlist_test.dart' as save_watchlist_test;
import 'domain/usecases/search_movies_test.dart' as search_movies_test;
import 'presentation/bloc/detail_movie/detail_movie_cubit_test.dart'
    as detail_movie_cubit_test;
import 'presentation/bloc/is_add_watch_list/is_add_watch_list_cubit_test.dart'
    as is_add_watch_list_cubit_test;
import 'presentation/bloc/now_playing_movie/now_playing_cubit_test.dart'
    as now_playing_cubit_test;
import 'presentation/bloc/popular_movie/popular_cubit_test.dart'
    as popular_cubit_test;
import 'presentation/bloc/recommendation_movie/recommendation_movie_cubit_test.dart'
    as recommendation_movie_cubit_test;
import 'presentation/bloc/search_movie/search_cubit_test.dart'
    as search_cubit_test;
import 'presentation/bloc/top_rated_movie/top_rated_cubit_test.dart'
    as top_rated_cubit_test;
import 'presentation/bloc/watch_list/watch_list_movie_cubit_test.dart'
    as watch_list_movie_cubit_test;

void main() {
  movie_local_data_source_test.main();
  movie_remote_data_source_test.main();
  get_movie_detail_test.main();
  get_movie_recommendations_test.main();
  get_now_playing_movies_test.main();
  get_popular_movies_test.main();
  get_top_rated_movies_test.main();
  get_watchlist_movies_test.main();
  get_watchlist_status_test.main();
  remove_watchlist_test.main();
  save_watchlist_test.main();
  search_movies_test.main();
  detail_movie_cubit_test.main();
  is_add_watch_list_cubit_test.main();
  now_playing_cubit_test.main();
  popular_cubit_test.main();
  recommendation_movie_cubit_test.main();
  search_cubit_test.main();
  top_rated_cubit_test.main();
  watch_list_movie_cubit_test.main();
}
