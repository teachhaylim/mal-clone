class AppConstant {
  static String baseUrl = "https://api.jikan.moe/v4/";
  static List<String> airingDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  static String randomUnsplashImage = "https://source.unsplash.com/random";
  static String placeholderImageUrl = "https://via.placeholder.com/300";
  static double scrollOffset = 0.7;
  static String youtubeSearch({required String searchQuery}) => "https://www.youtube.com/results?search_query=$searchQuery";
}
