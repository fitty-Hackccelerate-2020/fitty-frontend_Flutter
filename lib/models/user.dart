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
  Sleep sleep;
  WorkOut workOut;
  Goal goal;

  User({this.token, this.fullName, this.basicData, this.healthData, this.waterData,
    this.dailyData, this.diet, this.sleep, this.workOut, this.goal});

  factory User.fromJson(Map<String, dynamic> responseData) {
     print(" token = ${responseData['data']}");

    User user = User(token: responseData['data'] ?? null);
    user.token = responseData['token'] ?? null;
    user.fullName = responseData['full_name'] ?? null;

    print('basic');
    user.basicData = BasicData(
      age:responseData['age']/*??user.basicData.age*/,
      weight: responseData['weight'] /*?? user.basicData.weight*/,
      gender: responseData['gender'] /* ?? user.basicData.gender*/,
      height: responseData['height'] /*?? user.basicData.height*/,
      activityFreq: responseData['activityFrequency'] /*?? user.basicData.activityFreq*/
    );

    print('health');
    user.healthData = HealthData(
      BMI: responseData['bmi'] /*?? user.healthData.BMI*/,
      idealWeightRange: responseData['weightRange'] /*?? user.healthData.idealWeightRange*/
    );

    /*
    *
    * DailyData Start
    *
    * */
    print('daily');
    user.dailyData = DailyData(
        caloriesToConsume: responseData['caloriesToConsume'] /*?? user.dailyData.caloriesToConsume*/,
        caloriesConsumed:responseData['caloriesConsumed'] /*?? user.dailyData.caloriesConsumed*/,
        // drankWater:responseData['drankWater'] ?? user.dailyData.drankWater
    );

    print('workout');
    user.workOut = WorkOut(
        workoutName: responseData['workoutName'] /*?? user.workOut.workoutName*/,
        caloriesBurnt:responseData['caloriesBurnt'] /*?? user.workOut.caloriesBurnt*/
    );

    print('sleep');
    user.sleep = Sleep(
        sleepAt: responseData['sleepAt'] /*?? user.sleep.sleepAt*/,
        wokeupAt: responseData['wokeupAt'] /*?? user.sleep.wokeupAt*/
    );

    print('diet');
    user.diet = Diet(
        foodName: responseData['foodName'] /*?? user.diet.foodName*/,
        quantity: responseData['quantity'] /*?? user.diet.quantity*/,
        caloriesGot: responseData['caloriesGot'] /*?? user.diet.caloriesGot*/
    );

    print('water');
    user.waterData = WaterData(
      current: responseData['drankWater'] /*?? user.waterData.current*/,
      target: responseData['waterTarget'] /*?? user.waterData.target*/
    );

    print('goal');
    user.goal = Goal(
      targetWeight: responseData['goalWeight'] /*?? user.goal.targetWeight*/,
      targetWeightPerWeek: responseData['perWeekWeightGoal'] /*?? user.goal.targetWeightPerWeek*/
    );

    print("provider updated");
    /// previously this was factory method
    return user;
  }
}
