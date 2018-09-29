import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/models.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Channel> channels = [];

  Future<String> fetchPost() async {
    final response =
    await http.get('https://api.thingspeak.com/channels.json?api_key=M667PF8VRIA1OR61');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return response.body.toString();
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
        child: FutureBuilder<String>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
    return ListTile(
      title: Text(channel.name),
      subtitle: Text(channel.name),
      trailing: Text(channel.name),
    );
  }
}