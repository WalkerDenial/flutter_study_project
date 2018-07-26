import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class ContainerTestPage extends StatelessWidget {
  final title;
  ContainerTestPage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildImageWidget('images/pic1.jpg'),
                _buildImageWidget('images/pic2.jpg'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildImageWidget('images/pic3.jpg'),
                _buildImageWidget('images/pic4.jpg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 10.0, color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: EdgeInsets.all(4.0),
        child: Image.asset(imageUrl),
      ),
    );
  }
}
