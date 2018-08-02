import 'package:flutter/material.dart';
import '../constants/Dimens.dart';
import '../utils/ToastUtil.dart';

class _Choice {
  const _Choice({this.title, this.icon});
  final title;
  final icon;
}

const List<_Choice> _choices = const <_Choice>[
  const _Choice(title: 'CAR', icon: Icons.directions_car),
  const _Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const _Choice(title: 'BOAT', icon: Icons.directions_boat),
  const _Choice(title: 'BUS', icon: Icons.directions_bus),
  const _Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const _Choice(title: 'WALK', icon: Icons.directions_walk),
];

class _ChoiceCard extends StatelessWidget {
  final choice;
  _ChoiceCard({Key key, this.choice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 128.0,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomAppBarPage extends StatefulWidget {
  final title;
  BottomAppBarPage({this.title});
  @override
  createState() => _BottomAppBarState(title: title);
}

class _BottomAppBarState extends State<BottomAppBarPage>
    with SingleTickerProviderStateMixin {
  final title;
  TabController _tabController;
  _BottomAppBarState({this.title});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
    ToastUtil.showToast('The index is $newIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          elevation: Dimens.elevationTitle,
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: Icon(Icons.arrow_back),
            onPressed: () => _nextPage(-1),
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'Next choice',
              icon: Icon(Icons.arrow_forward),
              onPressed: () => _nextPage(1),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TabPageSelector(controller: _tabController),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _choices
              .map((cho) => Padding(
                    padding: EdgeInsets.all(16.0),
                    child: _ChoiceCard(choice: cho),
                  ))
              .toList(),
        ));
  }
}
