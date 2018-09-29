import 'package:flutter/material.dart';
import 'package:pokpak_thingspeak/home_page.dart';
import 'package:pokpak_thingspeak/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokPak Thingspeak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: 'Home Page'
        ],
      ),
    );
  }
}
