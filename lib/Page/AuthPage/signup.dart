import 'package:fitty/Page/detailsPage.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/auth.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatelessWidget {
  var width, height;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _preSet(),
            _formLogin(context),
          ],
        ),
      ),
    );
  }

  _preSet(){
    return Column(
      children: <Widget>[
        /// welcome text / banner / flow of app....

        Container(
          height: height / 2.5,
          padding: EdgeInsets.all(5),
          child: Image.asset('assets/set-your-goals.png', width: width, height: height/2),
        ),

      ],
    );
  }

  _formLogin(BuildContext context){
    return Container(
      height: height - height / 2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: Colors.white),
          color: Colors.white
      ),
      // color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: TextFormField(
                controller: fullName,
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    border: OutlineInputBorder(borderSide: BorderSide())
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(borderSide: BorderSide())
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              // padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(borderSide: BorderSide())
                ),
              ),
            ),
            _registerButton(context),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account ? "),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: Text('Login',
                                style: TextStyle(color: Colors.blue[200], fontWeight: FontWeight.bold))
                        ),
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  _registerButton(BuildContext context){
    return Center(
      child: RaisedButton(
        color: Colors.blue[200],
        shape: StadiumBorder(),
        onPressed: ()async{
          /// separate flow for APIs...
          // UserPreferences userPreferences = UserPreferences();
          // // userPreferences.getUser();
          // // UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
          // User u = await userPreferences.getUser();
          // print(u.token);
          // userPreferences.removeUser();
          _registerRequest(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text('Register', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  _registerRequest(BuildContext context) async{
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    Map<String, dynamic> response = await authProvider.register(email.text, password.text, fullName.text);
    if(response['status'] && authProvider.authStatus == Status.LoggedIn) {
      print('Register success');
      User registeredUser = response['user'];
      UserProvider userProvider =  Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(registeredUser);

      print('checking-token');
      print(registeredUser.token);
      // print(userProvider.user.token);

      Navigator.push(context, MaterialPageRoute(builder:
        (context) => DetailsPage()));
    }
    else{
      print(authProvider.authStatus);
      print(response['message']);
    }
    print("exit");
  }
}
