import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FeedChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  FeedChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    var chart = new charts.TimeSeriesChart(
      seriesList,
      animate: false,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: new charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        new charts.PointRendererConfig(
          // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
              zeroBound: false
          )
      ),
    );
    return Row(
      children: <Widget>[
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            "Left",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                "Title",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: chart,
              ),
              Text(
                "Bottom",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}