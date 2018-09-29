import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.channel}) : super(key: key);

  final String title;
  final List<Channel> channel;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title)
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: widget.channel.map((Channel channel) {
            return ChannelListItem(
              channel: channel,
            );
          }).toList(),
        )
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