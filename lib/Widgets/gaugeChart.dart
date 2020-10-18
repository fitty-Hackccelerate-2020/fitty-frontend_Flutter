import 'package:fitty/Page/Dashboard/DrinkingDeatils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GuageChartWidget extends StatelessWidget {
  double height;
  double percentage;
  int fontSize;
  double radius;
  List<charts.Series> seriesList;
  double stroke;
  int arcLength;
  GuageChartWidget(this.seriesList, this.percentage, this.radius,
      {this.height = 200.0,  this.fontSize = 20, this.stroke = 5, this.arcLength = 6});

  // static List<charts.Series<GaugeSegment, String>> _createSampleData() {
  //   final data = [
  //     new GaugeSegment('Low', 10),
  //     // new GaugeSegment('Acceptable', 75),
  //     // new GaugeSegment('High', 50),
  //     // new GaugeSegment('Highly Unusual', 95),
  //   ];
  //
  //   return [
  //     new charts.Series<GaugeSegment, String>(
  //       id: 'Segments',
  //       domainFn: (GaugeSegment segment, _) => segment.segment,
  //       measureFn: (GaugeSegment segment, _) => segment.size,
  //       colorFn: (GaugeSegment segment, _) => segment.color,
  //       data: data,
  //     )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    print(percentage);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      // color: Colors.pinkAccent,
      child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              if(height == 200)
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              Center(
                  child: CustomPaint(painter: DrawCircle(radius, stroke))
              ),
              Hero(
                tag: height == 170 ? 'waterCard' : 'eatCard',
                child: GaugeChart(seriesList , percentage, arcLength)
              ),
              Center(
                child: Text('${percentage.toStringAsFixed(2)} %', style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: double.parse(fontSize.toString()),
                  ),
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
      ),
    );
  }
}

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final double percentage;
  int arcLength;

  GaugeChart(this.seriesList, this.percentage, this.arcLength);

  /// Creates a [PieChart] with sample data and no transition.
  // factory GaugeChart.withSampleData() {
  //   return GaugeChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    print('building');
    return new charts.PieChart(seriesList,
        animate: true,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: arcLength, startAngle: 3*3.14/2, arcLength: 2*(22/7)*(percentage)/100));
  }

/// Create one series with sample hard coded data.

}

class GaugeSegment {

  final String segment;
  final double size;
  final charts.Color color = charts.Color(r: 104, g: 240, b: 174);

  GaugeSegment(this.segment, this.size);
}


class DrawCircle extends CustomPainter {
  double radius;
  double stroke;

  DrawCircle(this.radius, this.stroke);
  @override
  void paint(Canvas canvas, Size size) {
    // double radius = 75.0;
    canvas.translate(size.width/2, size.height/2);
    Offset center = Offset(0.0, 0.0);
    // draw shadow first
    // Path oval = Path()
    //   ..addOval(Rect.fromCircle(center: center, radius: radius+10));
    // Paint shadowPaint = Paint()
    //   ..color = Colors.black.withOpacity(0.2)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.inner, 50);
    // canvas.drawPath(oval, shadowPaint);
    // // draw circle
    Paint thumbPaint = Paint()
      ..color = Colors.blueGrey[100]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    canvas.drawCircle(center, radius, thumbPaint);
  }

  @override
  bool shouldRepaint(DrawCircle oldDelegate) {
    return true;
  }

//
// @override
// void paint(Canvas canvas, Size size) {
//
//     Paint brush = new Paint()
//       ..color = Colors.blueGrey
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10;
//
//   // var path = Path();
//   var center = Offset(75, 75);
//
//   //
//   // path.addOval(Rect.fromCircle(center: center, radius: 75.0));
//
//   canvas.drawCircle(Offset(75,75), 72.0, _paint);
//   // canvas.drawShadow(path, Colors.grey[300], 3, false);
// }
//
//
// @override
// bool shouldRepaint(CustomPainter oldDelegate) {
//   return false;
// }
}
