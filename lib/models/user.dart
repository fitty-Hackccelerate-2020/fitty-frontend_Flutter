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

  User({this.token});

  factory User.fromJson(Map<String, dynamic> responseData) {
    print(" token = ${responseData['data']}");

    User user = User(token: responseData['data'] ?? null);
    user.fullName = responseData['full_name']??null;

    user.basicData = BasicData(
      age:responseData['age'], weight: responseData['weight'],
      gender: responseData['gender'],
      height: responseData['height'], activityFreq: responseData['activityFrequency']
    );

    user.healthData = HealthData(
      BMI: responseData['bmi'],
      idealWeightRange: responseData['weightRange']
    );

    /*
    *
    * DailyData Start
    *
    * */

    user.dailyData=DailyData(caloriesToConsume: responseData['caloriesToConsume'],caloriesConsumed:responseData['caloriesConsumed'],drankWater:responseData['drankWater']);
    user.workOut=WorkOut(workoutName: responseData['workoutName'],caloriesBurnt:responseData['caloriesBurnt']);
    user.sleep=Sleep(sleepAt: responseData['sleepAt'],wokeupAt: responseData['wokeupAt']);
    user.diet=Diet(foodName: responseData['foodName'],quantity: responseData['quantity'],caloriesGot: responseData['caloriesGot']);


    if(responseData['water'] == null)
    user.waterData = WaterData(
      // current: responseData['water']['current']??0,
      // target: responseData['water']['target']??0
    );

    user.goal = Goal(
      targetWeight: responseData['goalWeight'],
      targetWeightPerWeek: responseData['perWeekWeightGoal']
    );

    return user;
  }
}
