import 'package:fitty/Widgets/gaugeChart.dart';
import 'package:fitty/models/user.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import 'DrinkingDeatils.dart';

class DrinkCard extends StatelessWidget {
  bool isDashBoard = false;
  static int newTarget;
  var width, height;
  static int target;
  static int current;
  static double percentage;
  static List<charts.Series> seriesList;

  DrinkCard({this.isDashBoard});

  static List<charts.Series<GaugeSegment, String>> _createGuageData(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    User user = userProvider.user;
    current = user.waterData.current;
    target = user.waterData.target;
    current = 6;
    // target = 12;
    newTarget = target??0;
    percentage = current/target * 100;

    final data = [
      new GaugeSegment('Low', percentage),
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
        color: Colors.blue,
        child: Container(
          width: width/2.5,
          height: 250,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DrinkingDetails(context, seriesList)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text("Water drank", textScaleFactor: 1),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      child: GuageChartWidget(seriesList, percentage, 38,
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
