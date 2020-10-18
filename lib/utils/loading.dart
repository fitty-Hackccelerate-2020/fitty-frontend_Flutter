import 'package:flutter/material.dart';

void loading1(BuildContext context, {String title = 'Loading...'}){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return Container(
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text(title)
          ],
        ),
      );
    }
  );
}

void loading(BuildContext context,{String title = 'Loading...'}) {
  showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) =>
      Container(
        color: Color.fromARGB(50, 0, 151, 255),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding( padding: EdgeInsets.all(5) ),
              Text(" $title ", style: TextStyle(fontSize: 20, color: Colors.blue[900],decoration: TextDecoration.none), )
            ],
          ),
        ),
      )
  );
}