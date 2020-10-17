import 'dart:convert';

import 'package:fitty/models/user.dart';
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
    user = Provider.of<UserProvider>(context, listen: false).user;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GetInitialData(),
        builder: (context, snapshot) {
          if(snapshot.data==ConnectionState.waiting||snapshot.data==ConnectionState.none)
            {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else
              {
               return NavigationPage();
              }
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
    var responseData = json.decode(response.body);
    print(responseData);
    user.dailyData.caloriesToConsume=responseData['data']['caloriesToConsume'];
    user.dailyData.caloriesConsumed=responseData['data']['caloriesConsumed'];
    user.dailyData.drankWater=responseData['data']['drankWater'];
    user.diet.foodName=responseData['data']['diet']['foodname'];
    user.diet.caloriesGot=responseData['data']['died']['caloriesGot'];
    user.diet.quantity=responseData['data']['died']['quantity'];
    user.sleep.wokeupAt=responseData['data']['sleep']['wokeupAt'];
    user.sleep.sleepAt=responseData['data']['sleep']['sleepAt'];
    user.workOut.caloriesBurnt=responseData['data']['workout']['caloriesBurnt'];
    user.workOut.workoutName=responseData['data']['workout']['workoutName'];
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
