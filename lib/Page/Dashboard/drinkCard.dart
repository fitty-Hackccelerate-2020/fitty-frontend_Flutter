import 'package:fitty/Widgets/gaugeChart.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import 'DrinkingDeatils.dart';

class DrinkCard extends StatelessWidget {
  BuildContext context;
  static int newTarget;
  var width, height;
  static int target;
  static int current;
  static double percentage;
  bool isDashBoard = false;
  static List<charts.Series> seriesList;
  static UserProvider userProvider;
  static User user;

  DrinkCard(this.context, {this.isDashBoard}){
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
  }

  static List<charts.Series<GaugeSegment, String>> _createGuageData(BuildContext context) {

    current = user.waterData.current;
    target = user.waterData.target;
    // current = 6;
    // target = 12;
    newTarget = target??0;
    percentage = current/target * 100;

    final data = [
      new GaugeSegment('Low', percentage % 101),
      // new GaugeSegment('high', .2),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    seriesList = _createGuageData(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      child: Card(
        color: Colors.cyan[100],
        child: Container(
          width: width/2.5,
          height: 250,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DrinkingDetails(context, seriesList)));
            },
            child: StatefulBuilder(
              builder: (BuildContext context, waterUpdateState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("Water drank", textScaleFactor: 1),
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          child: GuageChartWidget(seriesList, percentage % 100.1, 42,
                              height: 130, fontSize: 15, stroke: 4.0),
                        ),
                        Container(
                          width: width / 3 - 15,
                          height: 140,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DrinkingDetails(context, seriesList)));
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          onPressed: (){
                            user.waterData.current -= 1;
                            if(user.waterData.current <= 0)
                              user.waterData.current = 0;
                            seriesList = _createGuageData(context);
                            waterUpdateState((){});
                          },
                          icon: Icon(Icons.remove, color: Colors.red),
                        ),
                        Container(
                          child: Text('${user.waterData.current}/${user.waterData.target}'),
                        ),
                        IconButton(
                          onPressed: (){
                            user.waterData.current += 1;
                            if(user.waterData.current >= user.waterData.target)
                              user.waterData.current = 10;
                            seriesList = _createGuageData(context);
                            waterUpdateState((){});
                          },
                          icon: Icon(Icons.add, color: Colors.green),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
