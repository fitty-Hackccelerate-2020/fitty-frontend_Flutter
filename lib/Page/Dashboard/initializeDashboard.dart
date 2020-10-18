import 'dart:convert';

import 'package:fitty/models/DailyData.dart';
import 'package:fitty/models/basicDataModel.dart';
import 'package:fitty/models/goalModel.dart';
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
  UserProvider userProvider;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GetInitialData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return NavigationPage();
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }

  Future GetInitialData() async {
    print('getting');
    print(user.token);
    Map<String, dynamic> result;

    final Map<String, dynamic> DailyGoalData = {
      'token': user.token,
    };

    Fluttertoast.showToast(
        msg: "Please Wait Data is Loading", toastLength: Toast.LENGTH_LONG);
    Response response = await post(AppUrl.fetchTodayGoal,
        body: jsonEncode(DailyGoalData),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    print(response.statusCode);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    print('1' + "${!responseJson['error']}");
    print(responseJson);
    if (response.statusCode == 200 && !responseJson['error']) {
      print('if');
      print("rr@initialize ${responseJson['data']}");
      var responseData = responseJson['data'];
      print(responseData);
      user.basicData = BasicData(
          age: responseData['age'] ?? 0,
          weight: responseData['weight'] ?? 0.0,
          gender: responseData['gender'] ?? '',
          height: responseData['height'] ?? 0.0,
          activityFreq: responseData['activityFrequency'] ?? 'Select Activity');
      user.healthData = HealthData(
          BMI: responseData['bmi'] ?? 0.0,
          idealWeightRange: responseData['weightRange'] ?? [-1, -1]);
      user.dailyData = DailyData(
        caloriesToConsume: responseData['caloriesToConsume'] ?? 0,
        caloriesConsumed: responseData['caloriesConsumed'] ?? 0,
        // drankWater:responseData['drankWater'] ?? user.dailyData.drankWater
      );
      user.workOut = WorkOut(
          workoutName: responseData['workoutName'] ?? null,
          caloriesBurnt: responseData['caloriesBurnt'] ?? 0);
      user.sleep = Sleep(
          sleepAt: responseData['sleepAt'] ?? 0,
          wokeupAt: responseData['wokeupAt'] ?? 0);
      user.diet = Diet(
          foodName: responseData['foodName'] ?? '',
          quantity: responseData['quantity'] ?? 0,
          caloriesGot: responseData['caloriesGot'] ?? 0);
      user.waterData = WaterData(
          current: responseData['drankWater'] ?? 0,
          target: responseData['waterTarget'] ?? 10);
      user.goal = Goal(
          targetWeight: responseData['goalWeight'] ?? 0.0,
          targetWeightPerWeek: responseData['perWeekWeightGoal'] ?? 0.0);
      // user = User.fromJson(responseData['data'], token: user.token);
      user.ListofDiet = List<Diet>();

      print("updated to UserProvider");
      print(user.sleep.sleepAt);
      print(user.sleep.wokeupAt);
      return 'false';
    } else if (responseJson['error'] || response.statusCode != 200) {
      print('error @getInitialData()');
      print(responseJson['error']);
      Fluttertoast.showToast(msg: "Something Went Wrong @getInitialData()");
      return "true";
    } else {
      Fluttertoast.showToast(msg: "Loading-Error");
      return 'false';
    }
    /*update respose data*/
//    double bmi = double.parse(responseData['data']['bmi']);
//    d=double.parse(responseData['data']['bmi']);

//    Navigator.of(context)
//        .pushReplacement(MaterialPageRoute(builder: (context) => DashBoardPage()));
  }
}
