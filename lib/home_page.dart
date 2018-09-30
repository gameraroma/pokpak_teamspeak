import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/channel_page.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Channel> channels = [];

  Future<ChannelList> fetchChannels() async {
    final response =
    await http.get('https://api.thingspeak.com/channels.json?api_key=M667PF8VRIA1OR61');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var channelList = ChannelList.fromJson(json.decode(response.body));
      return channelList;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title)
      ),
      body: Center(
        child: FutureBuilder<ChannelList>(
          future: fetchChannels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ChannelList channelList = snapshot.data;
              channels = channelList.channels;
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                children: channels.map((Channel channel) {
                  return ChannelListItem(
                    channel: channel,
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        )
      ),
    );
  }
}

//typedef void CartChangedCallback(Channel product, bool inCart);

class ChannelListItem extends StatelessWidget {
  ChannelListItem({this.channel}) : super(key: ObjectKey(channel));

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('yyyy-MM-dd H:m');
    String createAtFormat = formatter.format(channel.createdAt);

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChannelPage(
              channel: channel,
          )),
        );
      },
      title: Text(channel.name),
      trailing: Text(createAtFormat),
    );
  }
}