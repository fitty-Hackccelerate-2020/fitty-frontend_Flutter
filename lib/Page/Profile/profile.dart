import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _personalDetailsTile(),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              _otherDetailsCard(),
            ],
          ),
        ),
      )
    );
  }

  _personalDetailsTile() {
    return Container(
      
      child: Row(
        children: <Widget>[
          Image.asset('assets/avatar-man.png', width: 100, height: 100),
          Column(
            children: <Widget>[
              Container(
                  child: Text('User name')
              ),
              Container(
                child: Text('User - since : October-2020')
              )
            ],
          )

        ],
      ),
    );
  }

  _otherDetailsCard() {
    return Card(
      elevation: 3,
      color: Colors.blue[50],
      child: Container(
        child: Column(
          children: <Widget>[
            _bodyDetaildTile(),
            _settingsTile(),
            _logOutTile()
          ],
        ),
      ),
    );

  }

  _bodyDetaildTile() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.blue[800]),
        title: Text('Basic Information'),
        subtitle: Text('Height, Weight, Age, Gender, Activity-level'),
      ),
    );
  }

  _settingsTile() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.flag, color: Colors.greenAccent),
        title: Text('Weight Goal'),
        subtitle: Text('view/update goal'),
      ),
    );
  }

  _logOutTile() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.power_settings_new, color: Colors.red),
        title: Text('Logout',),
        // subtitle: Text('Height, Weight, Age, Gender, Activity-level'),
      ),
    );
  }

}
