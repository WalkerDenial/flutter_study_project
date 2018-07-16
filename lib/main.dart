import 'package:flutter/material.dart';
import 'page/MainPage.dart';

void main() => runApp(AppEntrance());

class AppEntrance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(primaryColor: Colors.blue),
    );
  }
}
