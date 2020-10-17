import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkingDetails {
  BuildContext context;
  int target;
  int current;
  int newTarget;

  DrinkingDetails(this.context){
    /// only user Access from Provider....
    User user = Provider.of<UserProvider>(context, listen: false).user;
    current = user.waterData.current;
    target = user.waterData.target;
    newTarget = current??0;
  }

  openEditingSheet(){
    showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context){
        return Wrap(
          children: <Widget>[
            BottomSheet(
              onClosing: () {
                print("Closed");
              },
              builder: (BuildContext context){
                return Column(
                  children: <Widget>[
                    _staticInfo(context),
                    _dynamicInfo(context)
                  ],
                );
              },
            )
          ],
        );
    });
  }

  _staticInfo(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          padding: EdgeInsets.all(10),
          child: Text('Water consumption'),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Container(
          height: 200,
          color: Colors.pinkAccent,
          child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Text('Graph'),
                  ),
                  Center(
                    child: Text('Percentage % '),
                  )
                ],
              )
          ),
        ),
        Container(
          height: 50,
          child: Text('Total: $current/$target'),
        )
      ],
    );
  }

  _dynamicInfo(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text("Set water consumption target :"),
          subtitle: Container(
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    child: Icon(Icons.remove, color: Colors.red,)
                  ),
                ),
                Container(
                  child: Text('New target : $newTarget'),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.add, color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
