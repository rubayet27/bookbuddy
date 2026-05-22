class ApiEndpoints {
  static String baseUrlDev = "https://www.googleapis.com/books/v1";
  static String baseUrlProd = "https://www.googleapis.com/books/v1";
  static String allList = "/volumes";
  static String bookDetails(String id) => "/volumes/$id";
}
