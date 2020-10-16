class AppUrl {
  static const String liveBaseURL = "https://shiny-awful-wildebeast.gigalixirapp.com/api/v1";
  static const String localBaseURL = "http://192.168.1.106:3000/";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "auth/session";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";
}