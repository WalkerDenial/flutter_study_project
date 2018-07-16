import 'package:flutter/material.dart';
import '../constants/Strings.dart';

class EnglishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.englishList)),
      body: _EnglishListPage(),
    );
  }
}

class _EnglishListPage extends StatefulWidget {
  createState() => _EnglishListPageState();
}

class _EnglishListPageState extends State<_EnglishListPage> {
  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}
