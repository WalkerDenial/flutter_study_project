import 'package:flutter/material.dart';
import '../constants/Dimens.dart';
import 'package:english_words/english_words.dart';

class GridViewPage extends StatefulWidget {
  final title;
  GridViewPage({this.title});
  @override
  createState() => _GridViewPageState(title: title);
}

class _GridViewPageState extends State<GridViewPage> {
  final title;
  final _titleList = <_ItemBean>[];
  _GridViewPageState({this.title});
  @override
  Widget build(BuildContext context) {
    generateWordPairs().take(30).map((pair) {
      _titleList.add(_ItemBean(pair, false));
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 180.0,
        padding: EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List<Container>.generate(
            _titleList.length,
            (index) => Container(
                  child: GridTile(
                    footer: Container(
                      child: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(_titleList[index].pair.asPascalCase),
                        subtitle: Text(
                            'This is ${_titleList[index].pair.first.toLowerCase()} ${_titleList[index].pair.second.toLowerCase()}'),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _titleList[index].isFavorite =
                                    !_titleList[index].isFavorite;
                              });
                            },
                            icon: !_titleList[index].isFavorite
                                ? Icon(Icons.star_border, color: Colors.white)
                                : Icon(Icons.star, color: Colors.red)),
                      ),
                    ),
                    child: Image.asset('images/gt_pic${index + 1}.jpg'),
                  ),
                )),
      ),
    );
  }
}

class _ItemBean {
  WordPair pair;
  bool isFavorite;
  _ItemBean(this.pair, this.isFavorite);
}
