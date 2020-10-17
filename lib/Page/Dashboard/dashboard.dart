import 'package:fitty/Page/AuthPage/login.dart';
import 'package:fitty/Page/Profile/profile.dart';
import 'package:fitty/services/auth.dart';
import 'package:fitty/utils/shared_preference.dart';
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
  var width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _greetingSection(context),
          _mainInfo()
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
              Text("Hello, userName", style: TextStyle(fontSize: 20)),
//              Icon(Icons.pie_chart)
            _rewardsButton(context)
            ],
          )
        ],
      ),
    );
  }

  _mainInfo(){
    return Container(
      width: width,
      color: Colors.white,
      // height: height - height / 8,
      child: Column(
        children: <Widget>[
          _eatCard(),
          _groupCard(),
          _weekAnalyse(),
        ],
      ),
    );
  }

  _eatCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.blue,
        child: Container(
          // margin: EdgeInsets.all(10),
          // color: Colors.pinkAccent,
          // padding: EdgeInsets.all(20),
          height: height / 4,
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[

                ],
              ),
              Column(
                children: <Widget>[

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _groupCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          _drinkingCard(),
          _sleepingCard(),
          _workOutCard()
        ],
      ),
    );
  }

  _drinkingCard(){
    return Card(
      color: Colors.blue[100],
      child: Container(
        width: width / 3 - 15,
        height: 150,
      ),
    );
  }

  _sleepingCard(){
    return Card(
      color: Colors.grey[200],
      child: Container(
        width: width / 3 - 15,
        height: 150,
      ),
    );
  }

  _workOutCard(){
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

      },
      icon: Icon(Icons.flag),
    );
  }
}