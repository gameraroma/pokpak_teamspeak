import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:http/http.dart' as http;

class ChannelPage extends StatelessWidget {
  final Channel channel;
  List<Feed> feeds = [];

  ChannelPage({this.channel});

  Future<List<Feed>> fetchFeeds() async {
    final response =
    await http.get('https://api.thingspeak.com/channels/484437/feeds.json?api_key=C3BZNV7QADBY54J6&results=50');

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
      body: FutureBuilder<List<Feed>>(
        future: fetchFeeds(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            feeds = snapshot.data;
            return Text(feeds.toString());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      ),
    );
  }
}