import 'package:fitty/Page/SetGoal.dart';
import 'package:fitty/Page/detailsPage.dart';

import '../../Page/AuthPage/login.dart';
import '../../services/auth.dart';
import '../../utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            _otherDetailsCard(context),
          ],
        ),
      ),
    ));
  }

  _personalDetailsTile() {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset('assets/avatar-man.png', width: 100, height: 100),
          Column(
            children: <Widget>[
              Container(child: Text('D4Developer', textScaleFactor: 1, style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20
              ))),
              // Container(child: Text('User - since : October-2020'))
            ],
          )
        ],
      ),
    );
  }

  _otherDetailsCard(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.grey[100],
      child: Container(
        child: Column(
          children: <Widget>[
            _bodyDetaildTile(context),
            _settingsTile(context),
            _logOutTile(context)
          ],
        ),
      ),
    );
  }

  _bodyDetaildTile(context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DetailsPage(flagvar: true,)));
        },
        child: ListTile(
          leading: Icon(Icons.person, color: Colors.blue[800]),
          title: Text('Basic Information'),
          subtitle: Text('Height, Weight, Age, Gender, Activity-level'),
        ),
      ),
    );
  }

  _settingsTile(context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SetGoal()));
        },
        child: ListTile(
          leading: Icon(Icons.flag, color: Colors.greenAccent),
          title: Text('Weight Goal'),
          subtitle: Text('view/update goal'),
        ),
      ),
    );
  }

  _logOutTile(BuildContext context) {
    return Container(
      child: ListTile(
          leading: Icon(Icons.power_settings_new, color: Colors.red),
          title: Text(
            'Logout',
          ),
          // subtitle: Text('Height, Weight, Age, Gender, Activity-level'),
          onTap: () {
            _logoutAction(context);
          }),
    );
  }

  _logoutAction(BuildContext context) {
    UserPreferences().removeUser();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    authProvider.logOut();
    print("Sign-out");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
