import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class CaloriesBurnt extends StatefulWidget {
  @override
  _CaloriesBurntState createState() => _CaloriesBurntState();
}

class _CaloriesBurntState extends State<CaloriesBurnt> {
  User user;
  UserProvider userProvider;

  ValueNotifier<int> BurntCalories = ValueNotifier(0);
//  ValueNotifier<DateTime> WakeupAt = ValueNotifier(DateTime.now().add(Duration(hours: 0,minutes: 0)));
  TextEditingController num = TextEditingController();
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    num.text='0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _WillOnPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red[300],
          centerTitle: true,
          title: Text("Burnt Calories",style: TextStyle(color:Colors.white,letterSpacing: 3),),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.red[200],
            child: Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 100),
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: CircleAvatar(
                          backgroundColor: Colors.black38,
                          radius:100,child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/dumbell.png'),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:50.0),
                    child: Container(
                      child: Text("Select Your Burnt Calories",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: BurntCalories,
                    builder: (BuildContext context,newVal,child){
                      return Padding(
                        padding: const EdgeInsets.only(top: 15,left: 8,right: 8),
                        child: Container(
                            child: ListTile(
                              leading: IconButton(icon: Icon(Icons.remove_circle), onPressed: (){
                                print(newVal);
                                BurntCalories.value=newVal-1;
                                num.text=BurntCalories.value.toString();

                              }),
                              trailing: IconButton(icon: Icon(Icons.add_circle), onPressed: (){print(newVal);
                              BurntCalories.value=newVal+1;
                              num.text=BurntCalories.value.toString();
                              }),
                              title:TextField(
                                controller: num,
                                textAlign: TextAlign.center,

                                keyboardType: TextInputType.number,
                                onChanged: (val)
                                {
                                  BurntCalories.value=int.parse(val);
                                },
                              ),
                              ),
                            )
                        );

                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:25.0),
                    child: Container(
                      child: OutlineButton(
                        onPressed: () {
                          user.workOut.caloriesBurnt=int.parse(BurntCalories.value.toString());
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>NavigationPage()));
                        },
                        child:Text("Set Burnt Calories",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),) ,
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
  }

  Future<bool> _WillOnPop() async{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>NavigationPage()));
  }
}
