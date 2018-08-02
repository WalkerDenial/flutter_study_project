import 'package:flutter/material.dart';

class BasicAppBar extends StatefulWidget {
  final title;
  BasicAppBar({this.title});
  @override
  createState() => BasicAppBarState(title: title);
}

class BasicAppBarState extends State<BasicAppBar> {
  final title;
  _Choice _selectedChoice = _choices[0];

  BasicAppBarState({this.title});

  _select(choice) => setState(() => _selectedChoice = choice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(_choices[0].icon),
            onPressed: () => _select(_choices[0]),
          ),
          IconButton(
            icon: Icon(_choices[1].icon),
            onPressed: () => _select(_choices[1]),
          ),
          PopupMenuButton<_Choice>(
              onSelected: _select,
              itemBuilder: (context) => _choices
                  .skip(2)
                  .map((temp) => PopupMenuItem<_Choice>(
                      value: temp, child: Text(temp.title)))
                  .toList())
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _ChoiceCard(tmepChoice: _selectedChoice),
      ),
    );
  }
}

class _Choice {
  final title;
  final icon;
  const _Choice({this.title, this.icon});
}

const List<_Choice> _choices = const <_Choice>[
  const _Choice(title: 'Car', icon: Icons.directions_car),
  const _Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const _Choice(title: 'Boat', icon: Icons.directions_boat),
  const _Choice(title: 'Bus', icon: Icons.directions_bus),
  const _Choice(title: 'Train', icon: Icons.directions_railway),
  const _Choice(title: 'Walk', icon: Icons.directions_walk),
];

class _ChoiceCard extends StatelessWidget {
  final tmepChoice;

  _ChoiceCard({this.tmepChoice});
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              tmepChoice.icon,
              size: 128.0,
              color: style.color,
            ),
            Text(
              tmepChoice.title,
              style: style,
            )
          ],
        ),
      ),
    );
  }
}
