import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/utils/AppUrl.dart';
import 'package:fitty/utils/shared_preference.dart';


enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  UserProvider userProvider;
  User _user;

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get authStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Status set(Status status){
    _loggedInStatus = status;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;
    _loggedInStatus = Status.NotLoggedIn;
    final Map<String, dynamic> loginData = {
        'email': email,
        'password': password
    };

    // _loggedInStatus = Status.Authenticating;
    // notifyListeners();

    Response response;
    try{
      response = await post(
        AppUrl.login ,
        body: jsonEncode(loginData),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
    }
    catch(e){
      print("error_login");
      print(e.toString());
      _loggedInStatus = Status.NotLoggedIn;
      // notifyListeners();
      result = {
        'status': false,
        'message': 'something went wrong',
      };
      return result;
    }
    // result['status'] = false;

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _user = User(token: responseData['data']);
      await UserPreferences().saveUser(_user);
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();
      result = {
        'status': true,
        'user': _user
      };
      return result;
      // notifyListeners();
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      // notifyListeners();
      result = {
        'status': false,
        'message': responseData['data'],
      };
      notifyListeners();
      return result;
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String fullName) async {

    Map<String, dynamic> result;
    final Map<String, dynamic> registrationData = {
        'email': email,
        'password': password,
        'full_name': fullName
    };
    Response response;
     try{
       response  = await post(AppUrl.register,
           body: jsonEncode(registrationData),
           headers: {'Content-Type': 'application/json; charset=UTF-8'});

     }
     catch(e){
       print('Register error');
       print(e.toString());
     }
    Map<String, dynamic> responseData = jsonDecode(response.body);
    if(response.statusCode == 200){
      _user = User(token: responseData['data']);

      print(_user);
      _loggedInStatus = Status.LoggedIn;
      result = {
        'status' : true,
        'user': _user
      };
      await UserPreferences().saveUser(_user);
      notifyListeners();
    }
    else{
      result = {
        'status': false,
        'message': responseData['data']
      };
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
    }
    return result;
  }

  Future<void> logOut(){
    _loggedInStatus = Status.NotLoggedIn;
  }

}