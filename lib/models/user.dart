import 'waterModel.dart';
import 'basicDataModel.dart';
import 'goalModel.dart';
import 'healthDataModel.dart';

class User{
  String token;
  String fullName;
  BasicData basicData;
  HealthData healthData;
  WaterData waterData;
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
