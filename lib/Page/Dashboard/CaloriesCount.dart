import 'package:fitty/models/DailyData.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class CaloriesCount extends StatefulWidget {
  @override
  _CaloriesCountState createState() => _CaloriesCountState();
}

class _CaloriesCountState extends State<CaloriesCount> {
  TextEditingController _foodname = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _calories = TextEditingController();
  int TotalCaloriesConsumed = 0;
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  User user;

  @override
  void initState() {
    // TODO: implement initState
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    totalCal();
    super.initState();
  }


  totalCal(){
    TotalCaloriesConsumed = 0;
    user.ListofDiet.forEach((item) {
      TotalCaloriesConsumed += (item.caloriesGot*item.quantity);
    });
    user.dailyData.caloriesConsumed = TotalCaloriesConsumed;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Daily Calories",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                letterSpacing: 4),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => NavigationPage()));
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog();
          },
          tooltip: "Add Daily Consumed Calories",
          backgroundColor: Colors.grey[500],
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    color: Colors.orange[300],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Calories",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            "$TotalCaloriesConsumed/",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20),
                          )
                        ],
                      ),
                    )),
              ),
              Container(
                child: Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: user.ListofDiet.length??0,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text("${user.ListofDiet[index].foodName}"),
                            trailing: IconButton(icon: Icon(Icons.delete,color: Colors.redAccent,), onPressed:(){
                              print("1");
                              user.ListofDiet.remove(user.ListofDiet[index]);
                              totalCal();
                              setState(() {

                              });
                              print("2");
                            }),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${user.ListofDiet[index].quantity}q'),
                                Text('${user.ListofDiet[index].caloriesGot} KCAL')
                              ],

                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "Food Item"),
                          controller: _foodname,
                          keyboardType: TextInputType.text,
//                          autovalidate: _vlidate,

                          onChanged: (ressult) {
//                            item=ressult.toString();
                          },
                          validator: (String item) {
                            if (item.isEmpty) {
                              return "Enter Value";
                            } else {
                              return null;
                            }
                          },
                          autofocus: true,
                        ),
                        TextFormField(
                          controller: _quantity,

                          decoration:
                              InputDecoration(labelText: "No of Quantity"),
//                          autovalidate: _vlidate,
                          onChanged: (result) {
//                            amount=int.parse(result);
                          },
                          autofocus: true,
                          validator: (String item) {
                            if (item.isEmpty) {
                              return "Enter Value";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: _calories,
                          decoration: InputDecoration(
                              suffix: Text("KCAL"),
                              labelText: "Approx. Calories Per Quantity"),
//                          autovalidate: _vlidate,
                          onChanged: (result) {
//                            amount=int.parse(result);
                          },
                          autofocus: true,
                          validator: (String item) {
                            if (item.isEmpty) {
                              return "Enter Value";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: RaisedButton(
                              onPressed: () async {
                                if (_globalKey.currentState.validate()) {
                                  _globalKey.currentState.save();
//                                  print(item);
//                                  print(amount);
//                                  setState(() {});

                                  user.ListofDiet.add(Diet(
                                      foodName: _foodname.text,
                                      quantity: int.parse(_quantity.text),
                                      caloriesGot: int.parse(_calories.text)));
                                  _foodname.clear();
                                  _quantity.clear();
                                  _calories.clear();
                                  totalCal();
                                  Navigator.of(context).pop();
                                } else {
                                  setState(() {
//                                    _vlidate=true;
                                  });
                                }
                              },
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.white),
                              ),
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<bool> _onWillPop()async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>NavigationPage()));
  }
}
