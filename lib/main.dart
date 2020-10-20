import 'package:currency/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curreny',
      theme: ThemeData(
        accentColor: Colors.black,
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w500,
            fontFamily: "Butterskull"
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: Home(),
      ),
    );
  }
}
