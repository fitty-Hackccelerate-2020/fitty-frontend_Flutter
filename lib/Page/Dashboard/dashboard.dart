import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';

import '../../Page/Dashboard/DrinkingDeatils.dart';
import '../../Page/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    user = Provider.of<UserProvider>(context, listen: false).user;
    // print(user.dailyData.caloriesToConsume);
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
                      child: Text("Consumed calories : ")
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
          _drinkingCard(context),
          _sleepingCard(context),
          _workOutCard(context)
        ],
      ),
    );
  }

  _drinkingCard(BuildContext context){
    return InkWell(
      onTap: () {
        DrinkingDetails(context, user.waterData).openEditingSheet();
      },
      child: Card(
        color: Colors.blue[100],
        child: Container(
          width: width / 3 - 15,
          height: 150,
        ),
      ),
    );
  }

  _sleepingCard(BuildContext context){
    return Card(
      color: Colors.grey[200],
      child: Container(
        width: width / 3 - 15,
        height: 150,
      ),
    );
  }

  _workOutCard(BuildContext context){
    return Card(
      color: Colors.red[300],
      child: Container(
        width: width / 3 - 15,
        height: 150,
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