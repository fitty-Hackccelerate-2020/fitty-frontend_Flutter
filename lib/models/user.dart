class User {
  String token;

  User({this.token});

  factory User.fromJson(Map<String, dynamic> responseData) {
    print(" ff ${responseData['data']}");
    return User(
      token: responseData['data'],
    );
  }
}
