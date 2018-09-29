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
    await http.get('https://api.thingspeak.com/channels/${channel.id}/feeds.json?api_key=C3BZNV7QADBY54J6&results=50');

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

              var series = [
                charts.Series<Feed, DateTime>(
                  id: 'Clicks',
                  domainFn: (Feed feed, _) => feed.createdAt,
                  measureFn: (Feed feed, _) => int.tryParse(feed.field1),
                  data: feeds,
                ),
              ];

              var chart = charts.TimeSeriesChart(
                series,
                animate: true,
                behaviors: [
                  charts.RangeAnnotation([
                    charts.RangeAnnotationSegment(
                      feeds.first.createdAt,
                      feeds.last.createdAt,
                      charts.RangeAnnotationAxisType.domain
                    ),
                    charts.RangeAnnotationSegment(
                      1,
                      -1,
                      charts.RangeAnnotationAxisType.measure
                    ),
                  ]),
                ]
              );

              return chart;
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