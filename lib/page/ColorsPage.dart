import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

const double _kColorItemHeight = 48.0;

class _Palette {
  final name;
  final primary;
  final accent;
  final threshold;
  _Palette({this.name, this.primary, this.accent, this.threshold = 900});

  bool get isValid => name != null && primary != null && threshold != null;
}

final _allPalettes = <_Palette>[
  _Palette(
      name: 'RED',
      primary: Colors.red,
      accent: Colors.redAccent,
      threshold: 300),
  _Palette(
      name: 'PINK',
      primary: Colors.pink,
      accent: Colors.pinkAccent,
      threshold: 200),
  _Palette(
      name: 'PURPLE',
      primary: Colors.purple,
      accent: Colors.purpleAccent,
      threshold: 200),
  _Palette(
      name: 'DEEP PURPLE',
      primary: Colors.deepPurple,
      accent: Colors.deepPurpleAccent,
      threshold: 200),
  _Palette(
      name: 'INDIGO',
      primary: Colors.indigo,
      accent: Colors.indigoAccent,
      threshold: 200),
  _Palette(
      name: 'BLUE',
      primary: Colors.blue,
      accent: Colors.blueAccent,
      threshold: 400),
  _Palette(
      name: 'LIGHT BLUE',
      primary: Colors.lightBlue,
      accent: Colors.lightBlueAccent,
      threshold: 500),
  _Palette(
      name: 'CYAN',
      primary: Colors.cyan,
      accent: Colors.cyanAccent,
      threshold: 600),
  _Palette(
      name: 'TEAL',
      primary: Colors.teal,
      accent: Colors.tealAccent,
      threshold: 400),
  _Palette(
      name: 'GREEN',
      primary: Colors.green,
      accent: Colors.greenAccent,
      threshold: 500),
  _Palette(
      name: 'LIGHT GREEN',
      primary: Colors.lightGreen,
      accent: Colors.lightGreenAccent,
      threshold: 600),
  _Palette(
      name: 'LIME',
      primary: Colors.lime,
      accent: Colors.limeAccent,
      threshold: 800),
  _Palette(name: 'YELLOW', primary: Colors.yellow, accent: Colors.yellowAccent),
  _Palette(name: 'AMBER', primary: Colors.amber, accent: Colors.amberAccent),
  _Palette(
      name: 'ORANGE',
      primary: Colors.orange,
      accent: Colors.orangeAccent,
      threshold: 700),
  _Palette(
      name: 'DEEP ORANGE',
      primary: Colors.deepOrange,
      accent: Colors.deepOrangeAccent,
      threshold: 400),
  _Palette(name: 'BROWN', primary: Colors.brown, threshold: 200),
  _Palette(name: 'GREY', primary: Colors.grey, threshold: 500),
  _Palette(name: 'BLUE GREY', primary: Colors.blueGrey, threshold: 500),
];

MaterialColor _appBarColor = _allPalettes[0].primary;

class _ColorItem extends StatelessWidget {
  final index;
  final color;
  final prefix;
  const _ColorItem({
    Key key,
    @required this.index,
    @required this.color,
    this.prefix = '',
  })  : assert(index != null),
        assert(color != null),
        assert(prefix != null),
        super(key: key);
  String colorToString() =>
      '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        height: _kColorItemHeight,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        color: color,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$prefix$index'),
              Text(colorToString()),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaletteTabView extends StatelessWidget {
  static const List<int> _primaryKeys = const <int>[
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  ];
  static const List<int> _accentKeys = const <int>[100, 200, 400, 700];
  final colors;
  _PaletteTabView({Key key, @required this.colors})
      : assert(colors != null && colors.isValid),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final whiteTextStyle = textTheme.bodyText1.copyWith(color: Colors.white);
    final blackTextStyle = textTheme.bodyText1.copyWith(color: Colors.black);
    final colorItems = _primaryKeys.map((index) {
      return DefaultTextStyle(
        style: index > colors.threshold ? whiteTextStyle : blackTextStyle,
        child: _ColorItem(
          index: index,
          color: colors.primary[index],
        ),
      );
    }).toList();
    if (colors.accent != null) {
      colorItems.addAll(_accentKeys.map((index) {
        return DefaultTextStyle(
            style: index > colors.threshold ? whiteTextStyle : blackTextStyle,
            child: _ColorItem(
              index: index,
              color: colors.accent[index],
              prefix: 'A',
            ));
      }).toList());
    }
    return ListView(
      itemExtent: _kColorItemHeight,
      children: colorItems,
    );
  }
}

class ColorsPage extends StatefulWidget {
  final title;
  ColorsPage({this.title});
  @override
  createState() => _ColorsPageState(title: title);
}

TabController _controller;

class _ColorsPageState extends State<ColorsPage>
    with SingleTickerProviderStateMixin {
  final title;
  _ColorsPageState({this.title});
  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = TabController(vsync: this, length: _allPalettes.length);
      _controller.addListener(_handleTabSelection);
      _appBarColor = _allPalettes[0].primary;
    }
    return DefaultTabController(
      length: _allPalettes.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          elevation: Dimens.ELEVATION_TITLE,
          backgroundColor: _appBarColor,
          bottom: TabBar(
            isScrollable: true,
            tabs: _allPalettes.map((swatch) => Tab(text: swatch.name)).toList(),
            controller: _controller,
            indicatorColor: _appBarColor[700],
          ),
        ),
        body: TabBarView(
          children: _allPalettes
              .map((colors) => _PaletteTabView(colors: colors))
              .toList(),
          controller: _controller,
        ),
      ),
    );
  }

  void _handleTabSelection() {
    setState(() {
      if (_controller == null) return;
      _appBarColor = _allPalettes[_controller.index].primary;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }
}
