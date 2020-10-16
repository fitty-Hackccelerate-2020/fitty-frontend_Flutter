class AppUrl {
  static const String liveBaseURL = "";
  static const String localBaseURL = "http://192.168.1.106:3000/";

  static const String baseURL = localBaseURL;
  static const String login = baseURL + "auth/login";
  static const String register = baseURL + "auth/register";
  static const String forgotPassword = baseURL + "/forgot-password";
}