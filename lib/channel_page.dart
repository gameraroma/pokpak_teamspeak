import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/models.dart';

class ChannelPage extends StatelessWidget {
  final Channel channel;

  ChannelPage({this.channel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channel.name),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped!
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}