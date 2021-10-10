class ApiConstants {
  static const String tvLatest = "/tv/latest";
  static const String tvPopular = "/tv/popular";
  static const String tvTopRated = "/tv/top_rated";

  static String detailTv({required String tvId}) => "/tv/$tvId}";
}
