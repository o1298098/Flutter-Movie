import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/arrow_clipper.dart';

class SortMenu extends StatefulWidget {
  final String sort;
  final bool sortAsc;
  final Function(String, bool) onSortTap;
  const SortMenu({this.sort, this.sortAsc, this.onSortTap});
  @override
  _SortMenuState createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
  final double _width = 150;
  final double _arrowSize = 15.0;
  final List<String> _sortList = [
    "Domain",
    "Language",
    "Quality",
    "UpdateTime"
  ];
  String _sort;
  bool _asc;
  @override
  void initState() {
    _sort = widget.sort;
    _asc = widget.sortAsc ?? true;
    super.initState();
  }

  _onSortTap(String sort) {
    if (_sort == sort)
      _asc = !_asc;
    else
      _asc = true;
    _sort = sort;
    setState(() {});
    widget.onSortTap(sort, _asc);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    return Positioned(
      top: Adapt.px(120) + 25,
      left: 31,
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.bottomLeft,
              child: ClipPath(
                clipper: ArrowClipper(mode: 'up'),
                child: Container(
                  width: _arrowSize,
                  height: _arrowSize,
                  color: _backGroundColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _arrowSize / 2 - 1),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _sortList
                    .map(
                      (e) => _SortCell(
                        title: e,
                        selected: e == _sort,
                        asc: _asc,
                        onTap: _onSortTap,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SortCell extends StatelessWidget {
  final String title;
  final bool asc;
  final bool selected;
  final Function(String) onTap;
  const _SortCell({
    this.title,
    this.asc = false,
    this.onTap,
    this.selected = false,
  });
  @override
  Widget build(BuildContext context) {
    final Color _color = const Color(0xFFFFFFFF);
    return GestureDetector(
      onTap: () => onTap(title),
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: selected ? _color : Colors.transparent),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: _color,
                fontSize: 12,
              ),
            ),
            Spacer(),
            selected
                ? Icon(
                    asc
                        ? FontAwesomeIcons.sortAlphaDown
                        : FontAwesomeIcons.sortAlphaUp,
                    color: _color,
                    size: 12,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
