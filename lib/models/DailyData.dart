

class DailyData {
  int caloriesToConsume;
  int drankWater;
  int caloriesConsumed;

  DailyData({this.caloriesToConsume=0,this.caloriesConsumed=0,this.drankWater=0});

}


class Diet {
  String foodName;
  int quantity;

  int caloriesGot;

  Diet({this.foodName="",this.quantity=0,this.caloriesGot=0});
}

class Sleep
{
  int sleepAt = 0 ;
  int wokeupAt = 0;

  Sleep({this.sleepAt,this.wokeupAt});

}

class WorkOut
{
  String workoutName;
  int caloriesBurnt;

  WorkOut({this.workoutName,this.caloriesBurnt = 0});
}
