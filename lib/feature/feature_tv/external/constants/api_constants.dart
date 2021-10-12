class ApiConstants {
  static const String tvOnAir = "/tv/on_the_air";
  static const String tvPopular = "/tv/popular";
  static const String tvTopRated = "/tv/top_rated";

  static String detailTv({required String tvId}) => "/tv/$tvId";
  static String recommendationTv({required String tvId}) => "/tv/$tvId/recommendations";
}
