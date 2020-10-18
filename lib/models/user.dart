import 'waterModel.dart';
import 'basicDataModel.dart';
import 'goalModel.dart';
import 'healthDataModel.dart';
import 'DailyData.dart';

class User{
  String token;
  String fullName;
  BasicData basicData;
  HealthData healthData;
  WaterData waterData;
  DailyData dailyData;
  Diet diet;
  List<Diet> ListofDiet;
  Sleep sleep;
  WorkOut workOut;
  Goal goal;

  User({this.token, this.fullName, this.basicData, this.healthData, this.waterData,
    this.dailyData, this.diet, this.sleep, this.workOut, this.goal});

  factory User.fromJso(Map<String, dynamic> responseData, {String token, User preUser}) {
    // print(" token = ${responseData['data']}");

    User user = User(token: token ?? responseData['data'] ?? preUser.token ??'token = -1');
    // user.token = responseData['token'] ?? null;
    user.fullName = responseData['full_name'] ?? '';

    print('basic');
    user.basicData = BasicData(
      age: responseData['age'] ?? 0,
      weight: responseData['weight'] ?? 0.0,
      gender: responseData['gender'] ?? '',
      height: responseData['height'] ?? 0.0,
      activityFreq: responseData['activityFrequency'] ?? 'Select Activity'
    );

    print('health');
    user.healthData = HealthData(
      BMI: responseData['bmi'] ?? 0.0,
      idealWeightRange: responseData['weightRange'] ?? [-1,-1]
    );

    /*
    *
    * DailyData Start
    *
    * */
    print('daily');
    user.dailyData = DailyData(
        caloriesToConsume: responseData['caloriesToConsume'] ?? 0,
        caloriesConsumed:responseData['caloriesConsumed'] ?? 0,
        // drankWater:responseData['drankWater'] ?? user.dailyData.drankWater
    );

    print('workout');
    user.workOut = WorkOut(
        workoutName: responseData['workoutName'] ?? null,
        caloriesBurnt:responseData['caloriesBurnt'] ?? 0
    );

    print('sleep');
    user.sleep = Sleep(
        sleepAt: responseData['sleepAt'] ?? DateTime.now(),
        wokeupAt: responseData['wokeupAt'] ?? DateTime.now()
    );

    print('diet');
    user.diet = Diet(
        foodName: responseData['foodName'] ?? '',
        quantity: responseData['quantity'] ?? 0,
        caloriesGot: responseData['caloriesGot'] ?? 0
    );

    print('water');
    user.waterData = WaterData(
      current: responseData['drankWater'] ?? 0,
      target: responseData['waterTarget'] ?? 10
    );

    print('goal');
    user.goal = Goal(
      targetWeight: responseData['goalWeight'] ?? 0.0,
      targetWeightPerWeek: responseData['perWeekWeightGoal'] ?? 0.0
    );

    print("provider updated");
    print(user.token);
    /// previously this was factory method
    return user;
  }
}
