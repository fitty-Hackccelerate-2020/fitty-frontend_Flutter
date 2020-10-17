import 'dart:math';

import 'package:fitty/Page/AuthPage/login.dart';
import 'package:fitty/Page/Dashboard/dashboard.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserPreferences().getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if(snapshot.connectionState == ConnectionState.done){
          User loggedInUser = snapshot.data;

          print(loggedInUser.token);
          // print(loggedInUser.token);
          if(loggedInUser.token == null){
            print('not loggedIn');
            // Navigator.pop(context);
            return LoginPage();
          }
          UserProvider userProvider =  Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(loggedInUser);
          // Navigator.pop(context);
          return NavigationPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
