import 'package:flutter/material.dart';
import '../constants/Strings.dart';
import '../constants/Dimens.dart';
import '../bean/RouteBean.dart';
import 'EnglishListPage.dart';

class MainPage extends StatelessWidget {
  final _itemData = <RouteBean>[];

  void _initData(BuildContext context) {
    _itemData.add(RouteBean('English List Page',
        (context) => EnglishListPage(title: _itemData[0].name)));
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
              onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: _itemData[index ~/ 2].builder)),
            ),
    );
  }
}
