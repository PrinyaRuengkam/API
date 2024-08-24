import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://i.ibb.co/DrSp7td/20230116-124307.png'),
            ),
            SizedBox(height: 16),
            ProfileInfo('นายปริญญา เรืองคำ', 24, FontWeight.bold),
            ProfileInfo('เลขประจำตัว: 6512732105', 18),
            ProfileInfo('สาขา: วิทยาการคอมพิวเตอร์', 18),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const ProfileInfo(this.text, this.fontSize, [this.fontWeight = FontWeight.normal]);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
