import 'dart:convert';

import 'package:fitty/Page/AuthPage/signup.dart';
import 'package:fitty/Page/Dashboard/dashboard.dart';
import 'package:fitty/services/auth.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/AppUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  var width, height;
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
          height: height / 2,
          padding: EdgeInsets.all(5),
          child: Image.asset('assets/set-your-goals.png', width: width, height: height/2),
        ),

      ],
    );
  }

  _formLogin(BuildContext context){
    return Container(
      height: height - height / 2,
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
            _submitButton(context),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account ? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => SignUpPage()));
                      },
                      child: Container(
                        child: Text('Sign Up',
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

  _submitButton(BuildContext context){
    return Center(
      child: RaisedButton(
        color: Colors.blue[200],
        shape: StadiumBorder(),
        onPressed:() => _loginRequest(context),
          /// seperate flow for APIs....

          // var cred = jsonEncode({'email':'mayursiinh@gmail.com','password': 'fo'});
          // const headers = {
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'x-request-with': 'XMLHttpRequest'
          // };
          // try {
          //   String proxy = "https://cors-anywhere.herokuapp.com/";
          // var x  = await http.post( 'http://192.168.1.106:3000/auth/login', headers: headers, body: cred);
          // print('1');
          // print('Response status: ${x.statusCode}');
          // print(x.body);
          // }
          // catch(e){
          //   print(e.toString());
          // }
        // },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  _loginRequest(BuildContext context) async{
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    Map<String, dynamic> response = await authProvider.login(email.text, password.text);
    if(response == null){
      authProvider.logOut();
      print("error");
    }
    if(authProvider.authStatus == Status.LoggedIn && response['status']){
      Navigator.push(context, MaterialPageRoute(builder:
        (context) => DashBoardPage()));
      print('login success');
    }
    else{
      print(authProvider.authStatus);
      print(response['message']);
    }
    print("exit");
  }
}
