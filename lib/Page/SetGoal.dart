import 'dart:convert';

import 'package:fitty/Page/Dashboard/dashboard.dart';
import 'package:fitty/models/DailyData.dart';
import 'package:fitty/models/goalModel.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/AppUrl.dart';
import 'package:fitty/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class SetGoal extends StatefulWidget {
  bool flagvar;
  SetGoal({Key key, this.flagvar}):super(key:key);
  @override
  _SetGoalState createState() => _SetGoalState();
}

class _SetGoalState extends State<SetGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          "Weight Summary",
          style: TextStyle(color: Colors.black, letterSpacing: 3),
        ),
      ),
      body: SingleChildScrollView(child: WeightSummary(flagvar:widget.flagvar)),
    );
  }
}

//WeightSummary State Full Widget
var Suggestion = '';

class WeightSummary extends StatefulWidget {
  bool flagvar;
  WeightSummary({Key key,this.flagvar}):super (key:key);
  @override
  _WeightSummaryState createState() => _WeightSummaryState();
}

class _WeightSummaryState extends State<WeightSummary> {
  UserProvider userProvider;
  User user;
  var WeightText;
  var ConditionAccordingBMI;

  @override
  void initState() {
    // TODO: implement initState
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    user.healthData.BMI=user.healthData.BMI??0.0;
    user.healthData.idealWeightRange=user.healthData.idealWeightRange??[0,0];
    print(user.healthData.idealWeightRange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user.healthData.BMI < 18.5) {
      ConditionAccordingBMI = "Underweight";
      Suggestion =
      'According To BMI Your Weight is Low. You Should Increase Your Weight';
      WeightText = Text(
        "Underweight",
        style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
      );
    } else if (user.healthData.BMI >= 18.5 && user.healthData.BMI <= 24.9) {
      Suggestion =
      'According To BMI Your Weight Is Normal. You Should Keep Maintain Your Weight';
      ConditionAccordingBMI = 'Normal';
      WeightText = Text(
        "Normal",
        style: TextStyle(color: Colors.green, fontSize: 20),
      );
    } else if (user.healthData.BMI >= 25 && user.healthData.BMI <= 29.0) {
      Suggestion =
      'According To BMI You are Overweight. You Should Lose Your Weight';
      ConditionAccordingBMI = 'OverWeight';
      WeightText = Text(
        "OverWeight",
        style: TextStyle(color: Colors.redAccent, fontSize: 20),
      );
    } else {
      Suggestion =
      'According To BMI Your Weight is Too High You Should Lose Your Weight';
      ConditionAccordingBMI = "Obess";
      WeightText = Text(
        "Obess",
        style: TextStyle(color: Colors.red, fontSize: 20),
      );
    }
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.indigo[100],
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Image.asset('assets/bmi.png'),
                              ),
                            ),
                          ),
                          Text(
                            "Your BMI: ${user.healthData.BMI.toString()
                                .substring(0, 4)}",
                            style: TextStyle(fontSize: 10),
                          ),
                          WeightText
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                radius: 30,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset('assets/wheight.png'),
                                )),
                          ),
                          Text(
                            "Ideal Weight Range",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "${user.healthData.idealWeightRange[0]}-${user
                                .healthData.idealWeightRange[1]} Kg",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SetWeightGoalWidget(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: InkWell(
              onTap: () {
                UpdateData(context);

              },
              child: Card(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Set Target",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  UpdateData(context) async {
    print(user.token);
    Map<String, dynamic> result;
    if(weighlossgoal=='Set Goal Level') {
       Fluttertoast.showToast(msg: "Please Set Your Goal Speed",toastLength: Toast.LENGTH_LONG);
    }
    else{
      loading(context, title: "Creating Your Profile &\nSetting Your Goal");
      print(weighlossgoal);
      print("${user.goal.targetWeightPerWeek}");
      print("${user.goal.targetWeight}");

      final Map<String, dynamic> UpdateGoalData = {
        'goalWeight': user.goal.targetWeight,
        'perWeekWeightGoal': user.goal.targetWeightPerWeek,
        'token': user.token
      };

      Fluttertoast.showToast(
          msg: "Don't press back-button", toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2);

      Response response = await post(
          AppUrl.updateGoalData,
          body: jsonEncode(UpdateGoalData),
          headers: {'Content-Type': 'application/json; charset=UTF-8'}
      );

      print(response.statusCode);
      var responseData = jsonDecode(response.body);
      print(responseData);
      if(response.statusCode==200)
      {
        if(responseData['error']==false)
          {
            print('goal - data: ${responseData['data']}');
            user.dailyData = DailyData(
              caloriesConsumed: responseData['data']['caloriesConsumed'],
              caloriesToConsume: responseData['data']['caloriesToConsume']
            );

            // user = User.fromJson(responseData['data'], token: user.token, preUser: user);
            if(widget.flagvar==false){
              Navigator.pop(context);
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>NavigationPage()));
            }
            else{
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          }
          else{
            Fluttertoast.showToast(msg: "Something Went Wrong@setGoal.dart");
          }
      }

//    Navigator.of(context)
//        .pushReplacement(MaterialPageRoute(builder: (context) => SetGoal()));
    }
   }
}


/*Here Is The SetWeightGoalWidget*/

class SetWeightGoalWidget extends StatefulWidget {
  @override
  _SetWeightGoalWidgetState createState() => _SetWeightGoalWidgetState();
}

var weighlossgoal = "Set Goal Level";

class _SetWeightGoalWidgetState extends State<SetWeightGoalWidget> {
  final _formkey = GlobalKey<FormState>();
  UserProvider userProvider;
  User user;
  double weightgoal;

  void initState() {
    // TODO: implement initState
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    weightgoal = user.basicData.weight;
    user.goal.targetWeight = weightgoal;
//    print(user.healthData.idealWeightRange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Suggestion: ${Suggestion}",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Set Target Weight",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: InkWell(
                          child: Text(
                            "-",
                            style: TextStyle(fontSize: 30),
                          ),
                          onTap: () {
                            weightgoal = weightgoal - 0.5;
                            user.goal.targetWeight = weightgoal;
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        child: Text(
                          "$weightgoal",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                          child: InkWell(
                              onTap: () {
                                weightgoal = weightgoal + 0.5;
                                user.goal.targetWeight = weightgoal;
                                print(weightgoal);
                                setState(() {});
                              },
                              child: Text(
                                "+",
                                style: TextStyle(fontSize: 30),
                              )))
                    ],
                  ),
                ),
                Text("How quickly do you want to Achive Your Target ?"),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 80, right: 80, bottom: 50),
                  child: InkWell(
                      onTap: () {
                        SetGoalAccordingFromMenu(context).whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: Card(
                        color: Colors.grey[400],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "$weighlossgoal",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Icon(
                                Icons.accessibility,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SetGoalAccordingFromMenu(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        weighlossgoal = 'Maintain';
                        user.goal.targetWeightPerWeek=0.0;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Maintain"), Text("0.0 Kg/Week")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        weighlossgoal = 'Easy';
                        user.goal.targetWeightPerWeek=0.5;

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Easy"), Text("0.5 Kg/Week")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        weighlossgoal = 'Medium';
                        user.goal.targetWeightPerWeek=1.0;
                        print(user.goal.targetWeightPerWeek);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Medium"), Text("1.0 Kg/Week")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        weighlossgoal = 'Hard';
                        user.goal.targetWeightPerWeek=1.5;

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Hard"), Text("1.5 Kg/Week")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        weighlossgoal = 'Extreme';
                        user.goal.targetWeightPerWeek=2.0;

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Extreme"), Text("2.00 Kg/Week")],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


}

