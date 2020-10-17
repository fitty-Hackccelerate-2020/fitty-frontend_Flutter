import 'package:fitty/Page/SetGoal.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}
var _genderselect=0;

class _DetailsPageState extends State<DetailsPage> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    User registeredUser = userProvider.user;

    print(registeredUser.token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text(
          "Basic Info",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 5,
            fontSize: 22,
          ),
        ),
        actions: [
          Center(
              child: InkWell(
                  onTap: () {
                    //Done Button
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )))
        ],
      ),
      body: GetGenralInfoData(context, _formkey),
    );
  }
  GetGenralInfoData(context, _formkey) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/person.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/gender.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (){
                              _genderselect=0;
                              setState(() {

                              });

                            },
                            child: Container(
                              child: Center(child: Text("Male",style: TextStyle(color: Colors.white70),)),
                              decoration: BoxDecoration(
                                  color: _genderselect==0?Colors.lightGreen:Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)
                                  )
                              ),

                              height: 90,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5),),
                        Expanded(
                          flex: 1,
                          child:InkWell(
                            onTap: (){
                              _genderselect=1;
                              setState(() {

                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text("Women",style: TextStyle(color: Colors.white70),),
                              ),
                              decoration: BoxDecoration(
                                  color: _genderselect==1?Colors.pinkAccent:Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)
                                  )
                              ),

                              height: 90,
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/age.png'),
                    ),
                    title: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Age',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/scale.png'),
                    ),
                    title: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Height in CM',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/wheight.png"),
                    ),
                    title: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Weight',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/bmi.png"),
                    ),
                    title: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'BMI',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)))),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>SetGoal()));
                },
                child: Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Center(child: Text("Done",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,letterSpacing: 4,color: Colors.white70),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


