import 'package:flutter/material.dart';
import '../constants/Strings.dart';
import '../constants/Dimens.dart';
import '../bean/RouteBean.dart';
import 'EnglishListPage.dart';
import 'LakePage.dart';
import 'BasicAppBar.dart';
import 'TabBarAndAppBar.dart';
import 'ContainerTestPage.dart';
import 'GridViewPage.dart';
import 'ColorsPage.dart';

class MainPage extends StatelessWidget {
  final _pageNames = [
    'English List Page',
    'Lake Page',
    'Basic AppBar',
    'TabBar & AppBar',
    'Container Test',
    'GrideView Test',
    'Colors Page',
  ];
  final _itemData = <RouteBean>[];

  void _initData(BuildContext context) {
    _itemData.add(RouteBean(
        _pageNames[0], (context) => EnglishListPage(title: _pageNames[0])));
    _itemData.add(
        RouteBean(_pageNames[1], (context) => LakePage(title: _pageNames[1])));
    _itemData.add(RouteBean(
        _pageNames[2], (context) => BasicAppBar(title: _pageNames[2])));
    _itemData.add(RouteBean(
        _pageNames[3], (context) => TabBarAndAppBar(title: _pageNames[3])));
    _itemData.add(RouteBean(
        _pageNames[4], (context) => ContainerTestPage(title: _pageNames[4])));
    _itemData.add(RouteBean(
        _pageNames[5], (context) => GridViewPage(title: _pageNames[5])));
    _itemData.add(RouteBean(
        _pageNames[6], (context) => ColorsPage(title: _pageNames[6])));
  }

  @override
  Widget build(BuildContext context) {
    _initData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.home),
        centerTitle: true,
        elevation: Dimens.elevationTitle,
      ),
      body: _buildNavigationList(),
    );
  }

  Widget _buildNavigationList() {
    return ListView.builder(
      itemCount: _itemData.length * 2,
      itemBuilder: (context, index) => index.isOdd
          ? Divider(height: Dimens.divideHeight)
          : ListTile(
              title: Text(_itemData[index ~/ 2].toString()),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: _itemData[index ~/ 2].builder)),
            ),
    );
  }
}
