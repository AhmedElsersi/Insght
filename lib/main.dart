import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_project/ButtonNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBar())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF03045E), child: Image.asset('icons/insight.png'));
  }
}
