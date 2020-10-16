import 'package:fitty/Page/AuthPage/signup.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  var width, height;

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
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(borderSide: BorderSide())
                ),
              ),
            ),
            _submitButton(),
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

  _submitButton(){
    return Center(
      child: RaisedButton(
        color: Colors.blue[200],
        shape: StadiumBorder(),
        onPressed: (){
          /// seperate flow for APIs....
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
