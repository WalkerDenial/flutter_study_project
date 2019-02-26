import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../constants/Dimens.dart';

class AnimateListPage extends StatefulWidget {
  final title;
  AnimateListPage({Key key, this.title}) : super(key: key);
  @override
  createState() => _AnimateListPageState(title: title);
}

class _AnimateListPageState extends State<AnimateListPage> {
  final title;
  final _listKey = GlobalKey<AnimatedListState>();
  _ListModel<int> _list;
  int _selectedItem;
  int _nextitem;

  _AnimateListPageState({this.title});

  @override
  void initState() {
    super.initState();
    _list = _ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2],
      remoteItemBuilder: _buildRemovedItem,
    );
    _nextitem = 3;
  }

  _buildItem(context, index, animation) => _CardItem(
        animation: animation,
        item: _list[index],
        selected: _selectedItem == _list[index],
        onTap: () => setState(() {
              _selectedItem =
                  _selectedItem == _list[index] ? null : _list[index];
            }),
      );

  _buildRemovedItem(item, context, animation) => _CardItem(
        animation: animation,
        item: item,
        selected: false,
      );

  _insert() {
    _list.insert(
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem),
        _nextitem++);
  }

  _remove() {
    if (_selectedItem == null) return;
    _list.removeAt(_list.indexOf(_selectedItem));
    setState(() => _selectedItem = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.ELEVATION_TITLE,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: _insert,
            tooltip: 'insert a new item',
          ),
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: _remove,
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: (context, item, animation) =>
              _buildItem(context, item, animation),
        ),
      ),
    );
  }
}

class _ListModel<E> {
  final listKey;
  final remoteItemBuilder;
  final _items;

  _ListModel({
    @required this.listKey,
    @required this.remoteItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(remoteItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  AnimatedListState get _animateList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animateList.insertItem(index);
  }

  E removeAt(int index) {
    final removeItem = _items.removeAt(index);
    if (removeItem != null) {
      _animateList.removeItem(
          index,
          (context, animation) =>
              remoteItemBuilder(removeItem, context, animation));
    }
    return removeItem;
  }

  int get length => _items.length;
  E operator [](index) => _items[index];
  int indexOf(item) => _items.indexOf(item);
}

class _CardItem extends StatelessWidget {
  final animation;
  final onTap;
  final item;
  final selected;
  _CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Item $item',
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
