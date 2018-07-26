import 'package:flutter/material.dart';
import '../constants/Dimens.dart';
import 'package:english_words/english_words.dart';

class GridViewPage extends StatelessWidget {
  final title;
  GridViewPage({this.title});
  @override
  Widget build(BuildContext context) {
    final _titleList = <WordPair>[];
    _titleList.addAll(generateWordPairs().take(30));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200.0,
        padding: EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List<Container>.generate(
            30,
            (index) => Container(
                  child: GridTile(
                    footer: Container(
                      child: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(_titleList[index].asPascalCase),
                        subtitle: Text(
                            'This is ${_titleList[index].first.toLowerCase()} ${_titleList[index].second.toLowerCase()}'),
                        trailing: Icon(Icons.star_border, color: Colors.white),
                      ),
                    ),
                    child: Image.asset('images/gt_pic${index + 1}.jpg'),
                  ),
                )),
      ),
    );
  }
}
