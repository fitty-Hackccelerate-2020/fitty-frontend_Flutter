import 'dart:convert';

import 'package:fitty/Page/SetGoal.dart';
import 'package:fitty/models/DailyData.dart';
import 'package:fitty/models/basicDataModel.dart';
import 'package:fitty/models/goalModel.dart';
import 'package:fitty/models/healthDataModel.dart';
import 'package:fitty/models/waterModel.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/AppUrl.dart';
import 'package:flutter/material.dart';
import 'package:fitty/models/user.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DetailsPage extends StatefulWidget {
  bool flagvar;

  DetailsPage({Key key, this.flagvar}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

var _genderselect = -1;

class _DetailsPageState extends State<DetailsPage> {
  final _formkey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _ageController = TextEditingController();
  var _heightController = TextEditingController();
  var _weightController = TextEditingController();
  static String SelectActivity = "Select Activity";
  ValueNotifier<String> activityVal = ValueNotifier(SelectActivity);
  User user;

  @override
  void initState() {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    user=userProvider.user;
    if(widget.flagvar==true)
    {
      print("ok");
      print(" age ${user.basicData.age}");
      _nameController.text=user.fullName;
      _ageController.text=user.basicData.age.toString();
      _genderselect=user.basicData.gender=="Male"?0:1;
      _heightController.text=user.basicData.height.toString();
      _weightController.text=user.basicData.weight.toString();
      print(user.basicData.activityFreq);
      activityVal.value=user.basicData.activityFreq.toString();

    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        automaticallyImplyLeading: false,
        title: Text(
          "Basic Info",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 5,
            fontSize: 22,
          ),
        ),
        actions: [
          Center(
              child: InkWell(
                  onTap: () {
//                    User user;
//                    print(user.token);
                    //Done Button
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )))
        ],
      ),
      body: GetGenralInfoData(context, _formkey),
    );
  }

  GetGenralInfoData(context, _formkey) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/person.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/gender.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _genderselect = 0;
                              setState(() {});
                            },
                            child: Container(
                              child: Center(
                                  child: Text(
                                    "Male",
                                    style: TextStyle(color: Colors.white70),
                                  )),
                              decoration: BoxDecoration(
                                  color: _genderselect == 0
                                      ? Colors.lightGreen
                                      : Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8))),
                              height: 90,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _genderselect = 1;
                              setState(() {});
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Women",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: _genderselect == 1
                                      ? Colors.pinkAccent
                                      : Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8))),
                              height: 90,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/age.png'),
                    ),
                    title: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Age";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Age',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/scale.png'),
                    ),
                    title: TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Height in CM";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffix: Text("CM"),
                          hintText: 'Height in CM',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/weight.png"),
                    ),
                    title: TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Weight";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffix: Text("KG"),
                          hintText: 'Weight',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: activityLevel(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print(_genderselect);
                  print(_formkey.currentState.validate());
                  if (!_formkey.currentState.validate() ||
                      _genderselect == -1) {
                    print("True");
                    Fluttertoast.showToast(
                        msg:
                        "Please Update Data and Select Your Activity Level");
                  } else {
                    UpdateDetails(context);
                  }

                  //                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SetGoal()));
                },
                child: Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 4,
                            color: Colors.white70),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future SelectActivityFromMenu() {
    return showModalBottomSheet(
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
                        SelectActivity = 'No Activity';
                        activityVal.value = SelectActivity;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("No Activity")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        activityVal.value = 'Easy Activity';
                        SelectActivity = 'Easy Activity';
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Easy Activity")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        activityVal.value = 'Normal Activity';
                        SelectActivity = 'Normal Activity';
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Normal Activity")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        activityVal.value = 'High Activity';
                        SelectActivity = 'High Activity';
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("High Activity")],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        activityVal.value = 'Extreme Activity';

                        SelectActivity = 'Extreme Activity';
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text("Extreme Activity")],
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

  activityLevel() {
    return ValueListenableBuilder(
        valueListenable: activityVal,
        builder: (BuildContext context, newVal, child) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    SelectActivityFromMenu();
                  },
                  child: Card(
                    color: Colors.greenAccent[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            newVal,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Icon(
                            Icons.accessibility,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )));
        });
  }

  UpdateDetails(context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    User user = userProvider.user;

    print(user.token);
    Map<String, dynamic> result;
    double tempheight = double.parse(_heightController.text) / 100;
    final Map<String, dynamic> UpdateUserData = {

      // 'activityFreq': activityVal.value

      'full_name': _nameController.text,
      'weight': double.parse(_weightController.text),
      'height': tempheight,
      'age': int.parse(_ageController.text),
      'gender': _genderselect == 0 ? 'M' : 'F',
      'token': user.token,
    };

    Fluttertoast.showToast(
        msg: "Please Wait Data is Loading", toastLength: Toast.LENGTH_LONG);
    Response response = await post(AppUrl.updateUserData,
        body: jsonEncode(UpdateUserData),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    print(response.statusCode);
    var responseData = jsonDecode(response.body);
    print(responseData);

    /// update response data...
    if(response.statusCode == 200){
      print("updated W,H,A,Ac,G to server");
      print('DeatilsPage response = ${responseData}');

      // user.fullName = UpdateUserData['full_name'];
      // user.basicData.weight = UpdateUserData['weight'];
      // user.basicData.height = UpdateUserData['height'];
      // user.basicData.age = UpdateUserData['age'];
      // user.basicData.activityFreq = activityVal.value; /// should be UpdateUserData['activityFreq']
      // user.basicData.gender = UpdateUserData['gender'];

      user.fullName = _nameController.text;

      BasicData basicData = BasicData(
        age: int.parse(_ageController.text),
        weight: double.parse(_weightController.text),
        height: tempheight,
        activityFreq: activityVal.value,
        gender: _genderselect == 0 ? "M" : "F"
      );
      user.basicData = basicData;
      print(basicData.height);
      HealthData healthData = HealthData(
        BMI: double.parse(responseData['data']['bmi'].toString()),
        idealWeightRange: responseData['data']['weightRange']
      );
      user.healthData = healthData;
      user.goal = Goal();
      user.dailyData = DailyData();
      // user.healthData.BMI = double.parse(responseData['data']['bmi'].toString());
      // user.healthData.idealWeightRange = responseData['data']['weightRange'];
      user.workOut = WorkOut();
      user.waterData = WaterData();
      user.sleep = Sleep();
      user.diet = Diet();
      // user = User.fromJson(responseData['data'], token: user.token, preUser: user);

      print('updated BMI,Ideal weight range');
      if(widget.flagvar==false){
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => SetGoal(flagvar: false,)));
      }
      else{
        Navigator.of(context).pop();
      }
    }

    else{
      print('error @response_detailsPage.UpdateDetails()');
    }
    // user.fullName = _nameController.text;
    // user.basicData.weight = double.parse(_weightController.text);
    // user.basicData.height = double.parse(_heightController.text);
    // user.basicData.age = int.parse(_ageController.text);
    // user.basicData.activityFreq=activityVal.value;
    // user.basicData.gender = _genderselect == 0 ? "M" : "F";
    //
    // user.healthData.BMI = double.parse(responseData['data']['bmi'].toString());
    // print(user.healthData.BMI);
    // // print(responseData['data']['bmi']);
    // user.healthData.idealWeightRange = responseData['data']['weightRange'];

  }
}
