import 'package:fitty/Widgets/gaugeChart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/user_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DrinkingDetails extends StatelessWidget{
  static int target;
  static int current;
  static double percentage;
  int newTarget;
  BuildContext context;
  List<charts.Series> seriesList;

  DrinkingDetails(this.context, this.seriesList){
    /// only user Access from Provider....
    User user = Provider.of<UserProvider>(context, listen: false).user;
    current = user.waterData.current;
    target = user.waterData.target;
    current = 6;
    // target = 12;
    newTarget = target??0;
    percentage = current/target * 100;
   // seriesList = _createSampleData();
  }

 /* static List<charts.Series<GaugeSegment, String>> _createSampleData() {
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
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _staticInfo(context),
            _dynamicInfo(context)
          ],
        ),
      ),
    );
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
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
          child: Text('Water consumption in a day',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue
            )
          ),
        ),
        GuageChartWidget(seriesList, percentage, 75,
            height: 200, fontSize: 20, stroke: 6.0, arcLength: 10,
        ),
        Container(
          height: 50,
          child: Text('Total : $current/$target',
            style: TextStyle(
              fontSize: 20,
              color: percentage >= 50.0 ? Colors.green : Colors.redAccent
            )
          ),
        )
      ],
    );
  }

  _dynamicInfo(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            StatefulBuilder(
              builder: (BuildContext context, newTargetState){
                return Container(
                  // height: 100,
                  child: ListTile(
                    title: Text("Set daily water consumption target :",
                        style: TextStyle(
                            fontSize: 20
                        )
                    ),
                    subtitle: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              newTargetState((){
                                newTarget -= 1;
                                if(newTarget < 1)
                                  newTarget = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.remove, color: Colors.red,)
                            ),
                          ),
                          Container(
                            child: Text('New target : $newTarget',
                                style: TextStyle(
                                    fontSize: 20
                                )
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              newTargetState((){
                                newTarget += 1;
                                if(newTarget > 15)
                                  newTarget = 15;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.add, color: Colors.green),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              child: RaisedButton(
                color: Colors.blue,
                shape: StadiumBorder(),
                onPressed: () {

                },
                child: Text('Update water consumption target',
                  style: TextStyle(fontSize: 16),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}



/// Sample data type.




