import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class ExpansionPage extends StatelessWidget {
  final title;
  ExpansionPage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.ELEVATION_TITLE,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _EntryItem(_data[index]),
        itemCount: _data.length,
      ),
    );
  }
}

class _Entry {
  final String title;
  final List<_Entry> children;
  _Entry(this.title, [this.children = const <_Entry>[]]);
}

final _data = <_Entry>[
  _Entry(
    'Chapter A',
    <_Entry>[
      _Entry(
        'Section A0',
        <_Entry>[
          _Entry('Item A0.1'),
          _Entry('Item A0.2'),
          _Entry('Item A0.3'),
        ],
      ),
      _Entry('Section A1'),
      _Entry('Section A2'),
    ],
  ),
  _Entry('Chapter B', <_Entry>[
    _Entry('Section B0'),
    _Entry('Section B1'),
  ]),
  _Entry('Chapter C', <_Entry>[
    _Entry('Section C0'),
    _Entry('Section C1'),
    _Entry('Section C2', <_Entry>[
      _Entry('Item C2.0'),
      _Entry('Item C2.1'),
      _Entry('Item C2.2'),
      _Entry('Item C2.3'),
    ]),
  ]),
];

class _EntryItem extends StatelessWidget {
  final entry;
  _EntryItem(this.entry);

  Widget _buildTiles(_Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<_Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) => _buildTiles(entry);
}
