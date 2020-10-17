class AppUrl {
  static const String liveBaseURL = "https://whispering-tor-28801.herokuapp.com/";
  static const String localBaseURL = "http://192.168.1.106:3000/";

  static const String baseURL = localBaseURL;
  static const String login = liveBaseURL + "auth/login";
  static const String register = liveBaseURL + "auth/register";
  static const String forgotPassword = liveBaseURL + "/forgot-password";
  static const String updateUserData = liveBaseURL + "api/u/update";
  static const String updateGoalData = liveBaseURL + "api/t/initiate";

}