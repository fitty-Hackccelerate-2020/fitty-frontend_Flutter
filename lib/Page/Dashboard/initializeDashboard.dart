import 'dart:convert';

import 'package:fitty/models/basicDataModel.dart';
import 'package:fitty/models/healthDataModel.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/models/waterModel.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/AppUrl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class InitalizeDashboard extends StatefulWidget {
  @override
  _InitalizeDashboardState createState() => _InitalizeDashboardState();
}

class _InitalizeDashboardState extends State<InitalizeDashboard> {
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      body: FutureBuilder(
        future: GetInitialData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting||snapshot.connectionState==ConnectionState.none)
            {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if(snapshot.connectionState == ConnectionState.done)
              {
               return NavigationPage();
              }
            else
              return CircularProgressIndicator();
        },
      ),
    );
  }

  Future GetInitialData() async {
    print(user.token);
    Map<String, dynamic> result;

    final Map<String, dynamic> DailyGoalData = {
      'token':user.token,
    };

    Fluttertoast.showToast(
        msg: "Please Wait Data is Loading", toastLength: Toast.LENGTH_LONG);
    Response response = await post(AppUrl.fetchTodayGoal,
        body: jsonEncode(DailyGoalData),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    print(response.statusCode);

    Map<String, dynamic> responseData = jsonDecode(response.body);
    print('1');
    user = User.fromJson(responseData);

    print("updated to UserProvider");
    if(responseData['error']==false||response.statusCode!=200)
      {
        Fluttertoast.showToast(msg: "Something Went Wrong");
        return "true";
      }
      else
        {
          Fluttertoast.showToast(msg: "Loading");
          return 'false';
        }
    /*update respose data*/
//    double bmi = double.parse(responseData['data']['bmi']);
//    d=double.parse(responseData['data']['bmi']);

//    Navigator.of(context)
//        .pushReplacement(MaterialPageRoute(builder: (context) => DashBoardPage()));
  }
}
