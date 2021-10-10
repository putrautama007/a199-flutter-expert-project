class ApiConstants {
  static const String tvOnAir = "/tv/on_the_air";
  static const String tvPopular = "/tv/popular";
  static const String tvTopRated = "/tv/top_rated";

  static String detailTv({required String tvId}) => "/tv/$tvId}";
}
