import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../constants/Dimens.dart';
import '../utils/ToastUtil.dart';
import 'FavoritePage.dart';

final _saved = Set<WordPair>();

class EnglishListPage extends StatelessWidget {
  final title;
  EnglishListPage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.ELEVATION_TITLE,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FavoritePage(_saved))),
          )
        ],
      ),
      body: _EnglishListPage(),
    );
  }
}

class _EnglishListPage extends StatefulWidget {
  createState() => _EnglishListPageState();
}

class _EnglishListPageState extends State<_EnglishListPage> {
  final _suggestoins = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider(height: Dimens.DIVIDE_HEIGHT);
        final i = index ~/ 2;
        if (i >= _suggestoins.length)
          _suggestoins.addAll(generateWordPairs().take(10));
        final isContained = _saved.contains(_suggestoins[i]);
        return Dismissible(
          key: Key(_suggestoins[i].asPascalCase),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: Center(
              child: Text(
                'Deleted',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ),
          ),
          onDismissed: (direction) {
            final tempStr = _suggestoins[i].asPascalCase;
            ToastUtil.showToast('$tempStr dimissed.');
            setState(() {
              if (isContained) _saved.remove(_suggestoins[i]);
              _suggestoins.removeAt(i);
            });
          },
          child: ListTile(
            title: Text(
              _suggestoins[i].asPascalCase,
              style: _biggerFont,
            ),
            subtitle: Text('This is ${_suggestoins[i].asPascalCase}.'),
            trailing: Icon(isContained ? Icons.favorite : Icons.favorite_border,
                color: isContained ? Colors.red : null),
            onTap: () {
              setState(() {
                if (isContained) {
                  _saved.remove(_suggestoins[i]);
                } else {
                  _saved.add(_suggestoins[i]);
                }
              });
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _saved.clear();
    super.dispose();
  }
}
