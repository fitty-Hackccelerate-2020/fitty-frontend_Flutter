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
import 'ManageSleep.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  var width, height, index = 0;

  List<Widget> _navList = [
    DashBoardPage(),
    Text("History Page"),
    ProfilePage()
  ];

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
          body: _navList.elementAt(index),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/nav/home.png',height: 22,width: 22,),
                title: Text('Home')
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/nav/history.png',height: 22,width: 22,),
                title: Text('History')
              ),
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
    print(user.dailyData.caloriesToConsume ?? -1);
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: height / 8,
      width: width,
      color: Colors.redAccent,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/avatar-man.png'),
              Text("Hello, ${user.fullName}", style: TextStyle(fontSize: 20)),
//              Icon(Icons.pie_chart)
            _rewardsButton(context)
            ],
          )
        ],
      ),
    );
  }

  _mainInfo(BuildContext context){
    return Container(
      width: width,
      color: Colors.white,
      // height: height - height / 8,
      child: Column(
        children: <Widget>[
          _eatCard(),
          _groupCard(context),
          _weekAnalyse(),
        ],
      ),
    );
  }

  _eatCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        // color: Colors.blue,
        child: Container(
          // margin: EdgeInsets.all(10),
          // color: Colors.pinkAccent,
          // padding: EdgeInsets.all(20),
          height: height / 4,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width / 2 - 15,
                child: Column(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text("${user.dailyData.caloriesConsumed ?? -1}/${user.dailyData.caloriesToConsume}",style: TextStyle(fontSize: 15),),
                      ),
                    )

                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                width: 2,
                height: height/4 - 30,
              ),
              Container(
                width: width / 2 - 15,
                child: Column(
                  children: <Widget>[

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _groupCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          DrinkCard(isDashBoard: true),
          _sleepingCard(context),
          _workOutCard(context)
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
          width: width / 3 - 15,
          height: 150,
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
          width: width / 3 - 15,
          height: 150,
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
                  child: Text("293 Cal",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
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