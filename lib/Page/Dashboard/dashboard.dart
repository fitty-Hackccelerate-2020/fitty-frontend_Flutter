import 'package:fitty/Page/Dashboard/drinkCard.dart';
import 'package:fitty/Widgets/gaugeChart.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import '../../Page/Dashboard/DrinkingDeatils.dart';
import '../../Page/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'CaloriesBurnt.dart';
import 'CaloriesCount.dart';
import 'ManageSleep.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  var width, height, index = 0;
  User user;

  List<Widget> _navList = [
    DashBoardPage(),
//    Text("History Page"),
    ProfilePage()
  ];

  @override
  void initState() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    super.initState();
  }
  void _onItemTapped(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue[100],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[100],
            centerTitle: false,
            title: Text("Fitty", style:
              TextStyle(fontSize: 20, color: Colors.blue[900]),
              textScaleFactor: 1,
            )
          ),
          body: _navList.elementAt(index),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/nav/home.png',height: 22,width: 22,),
                title: Text('Home')
              ),
//              BottomNavigationBarItem(
//                icon: Image.asset('assets/nav/history.png',height: 22,width: 22,),
//                title: Text('History')
//              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/nav/profile.png',height: 22,width: 22,),
                title: Text('Profile')
              ),

            ],
            currentIndex: index,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class DashBoardPage extends StatelessWidget {
  User user;
  var width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    // print(user.dailyData.caloriesToConsume ?? -1);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _greetingSection(context),
          _mainInfo(context)
        ],
      ),
    );
  }

  _greetingSection(context){
    return Container();
  }

  _mainInfo(BuildContext context){
    return Container(
      width: width,
      color: Colors.white,
      // height: height - height / 8,
      child: Column(
        children: <Widget>[
          _eatCard(context),
          _groupCard(context),
//          _weekAnalyse(),
        ],
      ),
    );
  }

  List<charts.Series<GaugeSegment, String>> _createGuageData(BuildContext context, double percentage) {

    final data = [
      new GaugeSegment('Low', percentage),
      // new GaugeSegment('high', .2),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }

  _eatCard(BuildContext context) {
    double percentage = user.dailyData.caloriesConsumed/user.dailyData.caloriesToConsume * 100;
    List<charts.Series> seriesList = _createGuageData(context, percentage );
   print("height");
    print(height/4);
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        // color: Colors.blue,
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>CaloriesCount()));
          },
          child: Container(
            width: width,
            // margin: EdgeInsets.all(10),
            // color: Colors.pinkAccent,
            // padding: EdgeInsets.all(20),
            height: 200,
            child: Row(
              // direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/cal.png',height: 80,width: 80,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            child: Text
                              ("Daily Calories",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Text("${user.dailyData.caloriesConsumed ?? -1}/${user.dailyData.caloriesToConsume}",
                              style: TextStyle(fontSize: 15), textScaleFactor: 1.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   color: Colors.grey,
                //   width: 2,
                //   height: height/4 - 30,
                // ),
                Flexible(
                  child: Container(
                    // width: width / 2 - 15,
                    child: Column(
                      children: <Widget>[
                        GuageChartWidget(seriesList, percentage % 101, 58,
                            height: 195, fontSize: 20, stroke: 6.0, arcLength: 10)
                      ],
                    ),
                  ),
                ),
                /// for acchieving target
              ],
            ),
          ),
        ),
      ),
    );
  }

  _groupCard(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DrinkCard(context, isDashBoard: true),
          Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              _sleepingCard(context),
              _workOutCard(context)
            ],
          )
        ],
      ),
    );
  }

  _sleepingCard(BuildContext context){
    return Card(
      color: Colors.blueGrey,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(builder:(context)=>ManageSleep()));
        },
        child: Container(
          width: width / 2.5,
          height: 170,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.asset('assets/sleep.png',height: 60,width: 60,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Container(
                  child: Text("Daily Sleep",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.white),),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("${user.sleep.sleepAt}:${user.sleep.wokeupAt} Hours",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _workOutCard(BuildContext context){
    return Card(
      color: Colors.red[300],
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CaloriesBurnt()));
        },
        child: Container(
          width: width / 2.5,
          height: 170,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.asset('assets/workout.png',height: 60,width: 60,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Container(
                  child: Text("Burnt Calories",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.white),),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("${user.workOut.caloriesBurnt} Cal",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _weekAnalyse() {
    return Container(
      width: width,
      child: Card(
        child: Column(
          children: <Widget>[
            _title(),
            _barChartData(),
            _footNote()
          ],
        ),
      ),
    );
  }

  _title(){
    return Container(
        child: Text("Weekly Calories Gain")
    );
  }

  _barChartData(){
    return Container(
      height: 300,
      color: Colors.blue,
    );
  }

  _footNote(){
    return Container(
      child: Text('Addition FootNote Data'),
    );
  }

  _rewardsButton(BuildContext context){
    return IconButton(
      onPressed: () async{
        print("rewards button pressed");
      },
      icon: Icon(Icons.flag),
    );
  }
}