import 'package:fitty/Page/AuthPage/login.dart';
import 'package:fitty/services/auth.dart';
import 'package:fitty/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  set _loggedInStatus(Status _loggedInStatus) {}

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async{
        await UserPreferences().removeUser();
        AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.logOut();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context) => LoginPage()), (route) => false);
      },
      child: Text("Logout"),
    );
  }
}
