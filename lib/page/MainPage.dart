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
import 'BottomAppBarPage.dart';
import 'AnimateListPage.dart';
import 'ExpansionPage.dart';
import 'FadeAnimationPage.dart';
import 'SignaturePage.dart';
import 'DataLoaderPage.dart';
import 'InputTestPage.dart';
import 'SelfProgressBarPage.dart';
import 'NounPage.dart';
import 'KLinePage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatelessWidget {
  final _pageNames = [
    'English List Page',
    'Lake Page',
    'Basic AppBar',
    'TabBar & AppBar',
    'Container Test',
    'GrideView Test',
    'Colors Page',
    'BottomAppBar Page',
    'AnimateList Page',
    'Expansion Page',
    'FadeAnimation Page',
    'Signature Page',
    'DataLoader Page',
    'InputTest Page',
    'SelfProgressBar Page',
    'Noun Page',
    'K Line'
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
    _itemData.add(RouteBean(
        _pageNames[7], (context) => BottomAppBarPage(title: _pageNames[7])));
    _itemData.add(RouteBean(
        _pageNames[8], (context) => AnimateListPage(title: _pageNames[8])));
    _itemData.add(RouteBean(
        _pageNames[9], (context) => ExpansionPage(title: _pageNames[9])));
    _itemData.add(RouteBean(
        _pageNames[10], (context) => FadeAnimationPage(title: _pageNames[10])));
    _itemData.add(RouteBean(
        _pageNames[11], (context) => SignaturePage(title: _pageNames[11])));
    _itemData.add(RouteBean(
        _pageNames[12], (context) => DataLoaderPage(title: _pageNames[12])));
    _itemData.add(RouteBean(
        _pageNames[13], (context) => InputTestPage(title: _pageNames[13])));
    _itemData.add(RouteBean(_pageNames[14],
        (context) => SelfProgressBarPage(title: _pageNames[14])));
    _itemData.add(RouteBean(
        _pageNames[15], (context) => NounPage(title: _pageNames[15])));
    _itemData.add(RouteBean(
        _pageNames[16], (context) => KLinePage(title: _pageNames[16])));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    _initData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.home),
        centerTitle: true,
        elevation: Dimens.ELEVATION_TITLE,
      ),
      body: _buildNavigationList(),
    );
  }

  Widget _buildNavigationList() {
    return ListView.builder(
      itemCount: _itemData.length * 2,
      itemBuilder: (context, index) => index.isOdd
          ? Divider(height: Dimens.DIVIDE_HEIGHT)
          : ListTile(
              title: Text(_itemData[index ~/ 2].toString()),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: _itemData[index ~/ 2].builder)),
            ),
    );
  }
}
