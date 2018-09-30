import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/enums/feed_fields.dart';
import 'package:pokpak_thingspeak/feed_chart.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:http/http.dart' as http;
import 'package:pokpak_thingspeak/utils/parse_feed_series_list.dart';

class ChannelPage extends StatelessWidget {
  final Channel channel;
  FeedChannel feedChannel;
  List<Feed> feeds = [];

  ChannelPage({this.channel});

  Future<List<Feed>> fetchFeeds() async {
    ApiKey readApiKey = channel.apiKeys.firstWhere((i) => !i.writeFlag);
    final response = await http.get('https://api.thingspeak.com/channels/${channel.id}/feeds.json?api_key=${readApiKey.apiKey}&results=${channel.ranking}');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      feedChannel = FeedChannel.fromJson(json.decode(response.body)['channel'] as Map<String, dynamic>);
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
              var chart = new FeedChart(feeds, feedChannel, FeedField.field1);
              return Center(
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