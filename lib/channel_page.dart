import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/enums/feed_fields.dart';
import 'package:pokpak_thingspeak/feed_chart.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:http/http.dart' as http;

class ChannelPage extends StatelessWidget {
  final Channel channel;
  FeedChannel feedChannel;
  List<Feed> feeds = [];

  Map<String, dynamic> feedChannelJson;

  ChannelPage({this.channel});

  Future<List<Feed>> fetchFeeds() async {
    ApiKey readApiKey = channel.apiKeys.firstWhere((i) => !i.writeFlag);
    final response = await http.get('https://api.thingspeak.com/channels/${channel.id}/feeds.json?api_key=${readApiKey.apiKey}&results=${channel.ranking}');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      feedChannelJson = json.decode(response.body)['channel'] as Map<String, dynamic>;
      feedChannel = FeedChannel.fromJson(feedChannelJson);
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

              List<FeedField> feedFieldList = [];
              FeedField.values.where((f) => feedChannelJson[f.toString().split('.').last] != null).forEach((f) => feedFieldList.add(f));

              return ListView(
                children: feedFieldList.map((FeedField feedField) {
                  return FieldChartListItem(
                      feeds: feeds,
                      feedChannel: feedChannel,
                      feedField: feedField
                  );
                }).toList(),
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

class FieldChartListItem extends StatelessWidget {
  final List<Feed> feeds;
  final FeedChannel feedChannel;
  final FeedField feedField;

  FieldChartListItem({this.feeds, this.feedChannel, this.feedField}) : super(key: ObjectKey(feedField));

  @override
  Widget build(BuildContext context) {
    List<FeedFieldData> feedFieldData = [];
    for (var feed in feeds)
    {
      feedFieldData.add(FeedFieldData(feed.createdAt, _getValueTitle(feed, feedField)));
    }
    return ListTile(
      title: Card(
        child: Container(
          height: 250.0,
          child: new FeedChart(feedFieldData, feedChannel, feedField),
        ),
      ),
    );
  }

  String _getValueTitle(Feed feed,FeedField feedField) {
    switch (feedField) {
      case FeedField.field1:
        return feed.field1;
      case FeedField.field2:
        return feed.field2;
      case FeedField.field3:
        return feed.field3;
      case FeedField.field4:
        return feed.field4;
      case FeedField.field5:
        return feed.field5;
      case FeedField.field6:
        return feed.field6;
      case FeedField.field7:
        return feed.field7;
      case FeedField.field8:
        return feed.field8;
    }
  }
}