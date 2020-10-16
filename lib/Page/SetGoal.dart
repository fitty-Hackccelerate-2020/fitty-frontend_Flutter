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
        title: Text("Weight Summary",style: TextStyle(color: Colors.black,letterSpacing: 3),),
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

    );
  }
}

