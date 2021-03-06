import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pokpak_thingspeak/enums/feed_fields.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:pokpak_thingspeak/utils/parse_feed_series_list.dart';

class FeedChart extends StatelessWidget {
  List<FeedFieldData> feedFieldData;
  final FeedChannel feedChannel;
  final FeedField feedField;
  final bool animate;

  FeedChart(this.feedFieldData, this.feedChannel, this.feedField, {this.animate});

  @override
  Widget build(BuildContext context) {
    var seriesList = ParseFeedSeriesList.parseFeedSeriesList(feedFieldData, feedField);
    Widget chart;
    if (seriesList.first.data.length == 0) {
      chart = Center(
        child: Text("No Data"),
      );
    }
    else {
      chart = new charts.TimeSeriesChart(
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
    }
    return Row(
      children: <Widget>[
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            _getValueTitle(feedField),
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(68, 106, 148, 1.0),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                feedChannel.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: chart,
              ),
              Text(
                "Date",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(68, 106, 148, 1.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getValueTitle(FeedField feedField) {
    switch (feedField) {
      case FeedField.field1:
        return feedChannel.field1;
      case FeedField.field2:
        return feedChannel.field2;
      case FeedField.field3:
        return feedChannel.field3;
      case FeedField.field4:
        return feedChannel.field4;
      case FeedField.field5:
        return feedChannel.field5;
      case FeedField.field6:
        return feedChannel.field6;
      case FeedField.field7:
        return feedChannel.field7;
      case FeedField.field8:
        return feedChannel.field8;
    }
  }
}