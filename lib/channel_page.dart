import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class ChannelPage extends StatelessWidget {
  final Channel channel;
  List<Feed> feeds = [];

  ChannelPage({this.channel});

  Future<List<Feed>> fetchFeeds() async {
    final response =
    await http.get('https://api.thingspeak.com/channels/${channel.id}/feeds.json?api_key=KJMMNNESPD923P4B&results=50');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var feeds = (json.decode(response.body)['feeds'] as List).map((i) => Feed.fromJson(i)).toList();
      return feeds;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channel.name),
      ),
      body: Center(
        child: FutureBuilder<List<Feed>>(
          future: fetchFeeds(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              feeds = snapshot.data;
              
              var f1Feeds = feeds.where((i) => i.field1 != "").toList();

              var series = [
                charts.Series<Feed, DateTime>(
                  id: 'Clicks',
                  domainFn: (Feed feed, _) => feed.createdAt,
                  measureFn: (Feed feed, _) => int.tryParse(feed.field1.replaceAll("/\n", "").replaceAll("/\r", "").replaceAll("�", "")),
                  data: f1Feeds,
                ),
                charts.Series<Feed, DateTime>(
                  id: 'Clicks',
                  domainFn: (Feed feed, _) => feed.createdAt,
                  measureFn: (Feed feed, _) => int.tryParse(feed.field1.replaceAll("/\n", "").replaceAll("/\r", "").replaceAll("�", "")),
                  data: f1Feeds,
                )..setAttribute(charts.rendererIdKey, 'customPoint'),
              ];

              var chart = new charts.TimeSeriesChart(
                series,
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
                  behaviors: [
                    charts.RangeAnnotation([
                      charts.RangeAnnotationSegment(
                          feeds.first.createdAt,
                          feeds.last.createdAt,
                          charts.RangeAnnotationAxisType.domain
                      ),
                    ]),
                  ],
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.BasicNumericTickProviderSpec(
                        zeroBound: false
                    )
                  )
              );

              return Container(
                margin: EdgeInsets.all(10.0),
                height: 250.0,
                child: chart,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}