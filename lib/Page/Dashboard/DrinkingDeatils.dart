import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/user_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DrinkingDetails {
  int target;
  int current;
  int newTarget;
  BuildContext context;
  List<charts.Series> seriesList;

  DrinkingDetails(this.context){
    /// only user Access from Provider....
    User user = Provider.of<UserProvider>(context, listen: false).user;
    current = user.waterData.current;
    target = user.waterData.target;
    newTarget = current??0;

  }
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Low', 90),
      // new GaugeSegment('Acceptable', 100),
      // new GaugeSegment('High', 100),
      // new GaugeSegment('Highly Unusual', 5),
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
          child: Text('Water consumption', style: TextStyle(fontSize: 20)),
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
                  Center(
                    child: CustomPaint(painter: DrawCircle()),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(15),
                    //   child: Container(
                    //     height: 150,
                    //     width: 150,
                    //     // color: Colors.greenAccent,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey[300]),
                    //       borderRadius: BorderRadius.circular(150),
                    //         boxShadow: [new BoxShadow(
                    //           color: Colors.blueGrey,
                    //           blurRadius: 20.0,
                    //         ),]
                    //     ),
                    //   ),
                    // ),
                  ),
                  GaugeChart(_createSampleData()),
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

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() {
    return new GaugeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 15, startAngle: 3*3.14/2, arcLength: 6));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Low', 90),
      // new GaugeSegment('Acceptable', 100),
      // new GaugeSegment('High', 50),
      // new GaugeSegment('Highly Unusual', 95),
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
}

/// Sample data type.
class GaugeSegment {

  final String segment;
  final int size;
  final charts.Color color = charts.Color(r: 104, g: 240, b: 174);

  GaugeSegment(this.segment, this.size);
}

class DrawCircle extends CustomPainter {
  Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    // var path = Path();
    // var center = Offset(size.width / 2, size.height / 2);
    //
    // path.addOval(Rect.fromCircle(center: center, radius: 75.0));

    canvas.drawCircle(Offset(0.0, 0.0), 72.0, _paint);
    // canvas.drawShadow(path, Colors.grey[300], 3, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

