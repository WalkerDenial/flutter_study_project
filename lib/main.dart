import 'package:flutter/material.dart';
import 'page/MainPage.dart';

main() => runApp(AppEntrance());

class AppEntrance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(primaryColor: Colors.blue),
      // routes: <String, WidgetBuilder>{
      //   RoutePaths.PATH_PAGE_ENGLIST_LIST: (context) => EnglishListPage(),
      //   RoutePaths.PATH_PAGE_FAVORITE_LIST: (context) => FavoritePage()
      // },
    );
  }
}
