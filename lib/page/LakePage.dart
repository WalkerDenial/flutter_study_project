import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class LakePage extends StatefulWidget {
  final title;
  LakePage({this.title});
  @override
  createState() => _LakePage(title: title);
}

class _LakePage extends State<LakePage> {
  final title;
  int _collectCounts = 41;
  bool _hasCollected = true;
  _LakePage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: ListView(
        children: <Widget>[
          _buildImage(),
          _buildTitleRow(),
          _buildButton(context),
          _buildMessageText()
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      'images/lake.jpg',
      width: 600.0,
      height: 240.0,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTitleRow() {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: (_hasCollected ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: () => setState(() {
                  _hasCollected = !_hasCollected;
                  if (_hasCollected)
                    _collectCounts++;
                  else
                    _collectCounts--;
                }),
          ),
          Text('$_collectCounts'),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonItem(context, Icons.call, 'CALL'),
          _buildButtonItem(context, Icons.near_me, 'ROUTE'),
          _buildButtonItem(context, Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Widget _buildButtonItem(BuildContext context, IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );
  }
}
