import 'package:fitty/Page/detailsPage.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/auth.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/loading.dart';
import 'package:fitty/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatelessWidget {
  var width, height;
  final _formkey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Form(
      key: _formkey,
      child: Scaffold(
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
      ),
    );
  }

  _preSet() {
    return Column(
      children: <Widget>[
        /// welcome text / banner / flow of app....
        Container(
          padding: EdgeInsets.only(top: 30),
          height: height / 3,
          // padding: EdgeInsets.all(5),
          child: Image.asset('assets/set-your-goals.png',
              width: width, height: height / 3),
        ),
      ],
    );
  }

  _formLogin(BuildContext context) {
    return Container(
      // height: height - height / 2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      // color: Colors.white,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text('Register',
                textScaleFactor: 1, style: TextStyle(fontSize: 20)),
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter Name";
                } else {
                  return null;
                }
              },
              controller: fullName,
              decoration: InputDecoration(
                  hintText: 'Full Name',
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: TextFormField(
              controller: email,
              validator: (value) {
                if(value.isEmpty||validateEmail(email.text))
                  {
                    return "Enter Valid Email Address";
                  }
                  else
                    {
                      return null;
                    }
              },
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
          ),
          Container(

            padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
            // padding: EdgeInsets.all(10),
            child: TextFormField(
              validator: (value)
              {
                if(value.isEmpty||value.length<6)
                  {
                    return "Password Should Be Greater than 6";
                  }
                  else
                    {
                      return null;

                    }
              },
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(borderSide: BorderSide())),
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
                              style: TextStyle(
                                  color: Colors.blue[200],
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  _registerButton(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.blue[200],
        shape: StadiumBorder(),
        onPressed: () async {
         if(_formkey.currentState.validate())
           {
             loading(context);

             /// separate flow for APIs...
             // UserPreferences userPreferences = UserPreferences();
             // // userPreferences.getUser();
             // // UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
             // User u = await userPreferences.getUser();
             // print(u.token);
             // userPreferences.removeUser();
             _registerRequest(context);
           }
           else
             {
               Fluttertoast.showToast(msg: "Something Went Wrong");
             }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text('Register', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  _registerRequest(BuildContext context) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    Map<String, dynamic> response =
        await authProvider.register(email.text, password.text, fullName.text);
    if (response['status'] && authProvider.authStatus == Status.LoggedIn) {
      print('Register success');
      User registeredUser = response['user'];
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(registeredUser);

      print('checking-token');
      print(registeredUser.token);
      // print(userProvider.user.dailyData.caloriesToConsume);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    flagvar: false,
                  )));
    } else {
      print(authProvider.authStatus);
      print(response['message']);
    }
    print("exit");
  }
  validateEmail(String value) {
    print("This $value");
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return true;
    else
      return false;
  }
}
