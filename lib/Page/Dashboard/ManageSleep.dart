import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';
class ManageSleep extends StatefulWidget {
  @override
  _ManageSleepState createState() => _ManageSleepState();
}

class _ManageSleepState extends State<ManageSleep> {
  UserProvider userProvider;
  User user;

  ValueNotifier<DateTime> sleepAt = ValueNotifier(DateTime.now().add(Duration(hours: 0,minutes: 0)));
  ValueNotifier<DateTime> WakeupAt = ValueNotifier(DateTime.now().add(Duration(hours: 0,minutes: 0)));

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Sleep Tracking",style: TextStyle(color:Colors.white,letterSpacing: 3),),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey[300],
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
                          child: Image.asset('assets/sleeping.png'),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Container(
                    child: Text("Select Your Sleep Hours",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: sleepAt,
                  builder: (BuildContext context,newVal,child){
                    return Padding(
                      padding: const EdgeInsets.only(top: 15,left: 8,right: 8),
                      child: Container(
                          child: ListTile(
                            leading: Text("Sleeping Hours:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),),
                            title:OutlineButton(
                              child: Text("${newVal.hour} : ${newVal.minute}",style: TextStyle(color: Colors.white70),),
                              onPressed: (){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                      return CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime newdate) {
                                          sleepAt.value = newdate;
                                        },
                                        use24hFormat: true,
//                              maximumDate: new DateTime(2018, 12, 30),
//                              minimumYear: 2010,
//                              maximumYear: 2018,
                                        minuteInterval: 1,
                                        mode: CupertinoDatePickerMode.time,
                                      );
                                    });
                              },

                            ),
                          )
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top:25.0),
                  child: Container(
                    child: OutlineButton(
                      onPressed: () {
                        user.sleep.sleepAt = sleepAt.value.hour;
                        user.sleep.wokeupAt = sleepAt.value.minute;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return NavigationPage();
                        }));
                      },
                      child:Text("Set Sleep",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),) ,
                    ),
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
