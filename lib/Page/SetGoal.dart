import 'package:flutter/material.dart';

class SetGoal extends StatefulWidget {
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
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          "Weight Summary",
          style: TextStyle(color: Colors.black, letterSpacing: 3),
        ),
      ),
      body: WeightSummary(),
    );
  }
}

//WeightSummary State Full Widget

class WeightSummary extends StatefulWidget {
  @override
  _WeightSummaryState createState() => _WeightSummaryState();
}

class _WeightSummaryState extends State<WeightSummary> {
  @override
  Widget build(BuildContext context) {
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
                            "Your BMI: 22",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "Normal",
                            style: TextStyle(fontSize: 20),
                          )
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
                            "50-60 Kg",
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
            child: Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Commit",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*Here Is The SetWeightGoalWidget*/

class SetWeightGoalWidget extends StatefulWidget {
  @override
  _SetWeightGoalWidgetState createState() => _SetWeightGoalWidgetState();
}


var weighlossgoal="";
class _SetWeightGoalWidgetState extends State<SetWeightGoalWidget> {
  final _formkey = GlobalKey<FormState>();
  var weightgoal=61.0;
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
                Text(
                  "Set Target Weigth",
                  style: TextStyle(),
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
                            weightgoal=weightgoal-0.5;
                            setState(() {

                            });
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
                                weightgoal=weightgoal+0.5;
                                print(weightgoal);
                                setState(() {

                                });
                              },
                              child: Text(
                                "+",
                                style: TextStyle(fontSize: 30),
                              )))
                    ],
                  ),
                ),
                Text("How quickly do you want to lose weight ?"),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 80, right: 80, bottom: 50),
                  child: InkWell(
                      onTap: () {
                        SetGoalAccordingFromMenu(context).whenComplete(() {
                          setState(() {

                          });
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
                    onTap: (){
                      weighlossgoal='Easy';
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("Easy"), Text("0.25 Kg/Week")],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      weighlossgoal='Medium';
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("Medium"), Text("0.25 Kg/Week")],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      weighlossgoal='Hard';
                      Navigator.of(context).pop();
                    },
                    child: Container(

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("Hard"), Text("0.25 Kg/Week")],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      weighlossgoal='Extreme';
                      Navigator.of(context).pop();

                    },
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("Extreme"), Text("0.25 Kg/Week")],
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
