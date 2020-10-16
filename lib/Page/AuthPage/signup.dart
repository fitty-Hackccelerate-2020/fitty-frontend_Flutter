import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
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
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    border: OutlineInputBorder(borderSide: BorderSide())
                ),
              ),
            ),
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
            _RegisterButton(),
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

  _RegisterButton(){
    return Center(
      child: RaisedButton(
        color: Colors.blue[200],
        shape: StadiumBorder(),
        onPressed: (){
          /// seperate flow for APIs....
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text('Register', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
