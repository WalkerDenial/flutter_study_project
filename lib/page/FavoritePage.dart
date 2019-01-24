import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../constants/Dimens.dart';
import '../utils/ToastUtil.dart';
import '../constants/Strings.dart';

class FavoritePage extends StatelessWidget {
  final _pair = <WordPair>[];
  FavoritePage(Set<WordPair> temp) {
    _pair.addAll(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.favoritePage),
        elevation: Dimens.ELEVATION_TITLE,
      ),
      body: ListView.builder(
        itemCount: _pair.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider(height: Dimens.DIVIDE_HEIGHT);
          return ListTile(
            title: Text(_pair[index ~/ 2].asPascalCase),
            subtitle: Text('This is ${_pair[index ~/ 2].asPascalCase}.'),
            onTap: () => ToastUtil.showToast(
                'This is ${_pair[index ~/ 2].asPascalCase}.'),
          );
        },
      ),
    );
  }
}
