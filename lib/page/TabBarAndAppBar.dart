import 'package:flutter/material.dart';

class TabBarAndAppBar extends StatefulWidget {
  final String title;

  TabBarAndAppBar({this.title});

  @override
  createState() => TabBarAndAppBarState(title: title);
}

class TabBarAndAppBarState extends State<TabBarAndAppBar> {
  final String title;
  TabBarAndAppBarState({this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _choices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            isScrollable: true,
            tabs: _choices
                .map((item) => Tab(
                      text: item.title,
                      icon: Icon(item.icon),
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _choices
              .map((item) => Padding(
                    padding: EdgeInsets.all(16.0),
                    child: _ChoiceCard(tmepChoice: item),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _Choice {
  final String title;
  final IconData icon;
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
  final _Choice tmepChoice;

  _ChoiceCard({this.tmepChoice});
  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.display1;
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
