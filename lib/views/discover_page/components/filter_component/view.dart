import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/sort_condition.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/discover_page/components/filter_component/action.dart';

import 'state.dart';

Widget buildView(
    FilterState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: Adapt.px(30)),
        children: [
          _Title(dispatch: dispatch),
          _MediaTypePanel(
            isMovie: state.isMovie,
            onTap: (d) => dispatch(FilterActionCreator.mediaTypeChange(d)),
          ),
          _SortPanel(
            sortTypes: state.sortTypes,
            selected: state.selectedSort,
            sortDesc: state.sortDesc,
            dataSortChange: (d) =>
                dispatch(FilterActionCreator.dataSortChange(d)),
            onSelected: (s) => dispatch(FilterActionCreator.onSortChanged(s)),
          ),
          _GenresPanel(
            genres: state.currentGenres,
            onTap: (d) => dispatch(FilterActionCreator.onGenresChanged(d)),
          ),
          _VoteFilterPanel(
            lvote: state.lVote,
            rvote: state.rVote,
            onChange: (l, r) =>
                dispatch(FilterActionCreator.votefilterChange(l, r)),
          )
        ],
      )),
    );
  });
}

class _Title extends StatelessWidget {
  final Dispatch dispatch;
  const _Title({this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => dispatch(FilterActionCreator.applyFilter()),
            child: Container(
              height: Adapt.px(45),
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
              decoration: BoxDecoration(
                  color: const Color(0xFF334455),
                  borderRadius: BorderRadius.circular(Adapt.px(10))),
              child: Center(
                child: Text(
                  'Apply',
                  style: TextStyle(
                      fontSize: Adapt.px(20), color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(width: Adapt.px(20)),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: Adapt.px(45),
              height: Adapt.px(45),
              padding: EdgeInsets.all(Adapt.px(8)),
              decoration: BoxDecoration(
                  color: const Color(0xFF334455),
                  borderRadius: BorderRadius.circular(Adapt.px(10))),
              child: Icon(
                Icons.close,
                size: Adapt.px(28),
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaTypePanel extends StatelessWidget {
  final bool isMovie;
  final Function(bool) onTap;
  const _MediaTypePanel({this.isMovie, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(150),
      margin: EdgeInsets.only(top: Adapt.px(30), bottom: Adapt.px(20)),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Media Type',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: Adapt.px(30)),
          Row(children: [
            _TapCell<bool>(
              title: 'Movie',
              selected: isMovie,
              value: true,
              onTap: onTap,
            ),
            SizedBox(width: Adapt.px(20)),
            _TapCell<bool>(
              title: 'TvShow',
              selected: !isMovie,
              onTap: onTap,
              value: false,
            ),
          ])
        ],
      ),
    );
  }
}

class _TapCell<T> extends StatelessWidget {
  final String title;
  final T value;
  final Function(T) onTap;
  final bool selected;
  const _TapCell({this.title, this.onTap, this.selected = false, this.value});
  @override
  Widget build(BuildContext context) {
    final TextStyle _seletedStyle = TextStyle(
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
        fontSize: Adapt.px(24));
    final TextStyle _unSelectedStyle = TextStyle(
        color: const Color(0xFF9E9E9E),
        fontWeight: FontWeight.w500,
        fontSize: Adapt.px(24));
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        height: Adapt.px(60),
        padding: EdgeInsets.symmetric(
            vertical: Adapt.px(13), horizontal: Adapt.px(25)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(30)),
          color: selected ? const Color(0xFF334455) : null,
          border: Border.all(color: const Color(0xFF9E9E9E)),
        ),
        child: Text(
          title,
          style: selected ? _seletedStyle : _unSelectedStyle,
        ),
      ),
    );
  }
}

class _SortPanel extends StatelessWidget {
  final List<SortCondition> sortTypes;
  final Function(SortCondition) onSelected;
  final Function(bool) dataSortChange;
  final SortCondition selected;
  final bool sortDesc;
  const _SortPanel(
      {this.sortTypes,
      this.selected,
      this.onSelected,
      this.dataSortChange,
      this.sortDesc});
  @override
  Widget build(BuildContext context) {
    final _dataSorts = [
      SortCondition(name: 'Desc', value: true),
      SortCondition(name: 'Asc', value: false)
    ];
    return Container(
      height: Adapt.px(140),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              child: Row(
                children: [
                  const Text(
                    'Sorted by',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    '${sortDesc ? 'Desc' : 'Asc'}',
                    style: TextStyle(
                        fontSize: Adapt.px(20), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: Adapt.px(20)),
                  PopupMenuButton<SortCondition>(
                    padding: EdgeInsets.zero,
                    offset: Offset(0, Adapt.px(100)),
                    child: Icon(
                      Icons.sort,
                      size: Adapt.px(30),
                    ),
                    onSelected: (selected) => dataSortChange(selected.value),
                    itemBuilder: (ctx) {
                      return _dataSorts.map((s) {
                        final unSelectedStyle = TextStyle(color: Colors.grey);
                        final selectedStyle =
                            TextStyle(fontWeight: FontWeight.bold);
                        return PopupMenuItem<SortCondition>(
                          value: s,
                          child: Row(
                            children: <Widget>[
                              Text(
                                s.name,
                                style: s.value == sortDesc
                                    ? selectedStyle
                                    : unSelectedStyle,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              s.value == sortDesc
                                  ? Icon(Icons.check)
                                  : SizedBox()
                            ],
                          ),
                        );
                      }).toList();
                    },
                  )
                ],
              )),
          SizedBox(height: Adapt.px(40)),
          SizedBox(
            height: Adapt.px(60),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(20)),
              itemCount: sortTypes.length,
              itemBuilder: (_, index) {
                return _TapCell<SortCondition>(
                  title: sortTypes[index].name,
                  value: sortTypes[index],
                  selected: sortTypes[index] == selected,
                  onTap: onSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GenresPanel extends StatelessWidget {
  final List<SortCondition> genres;
  final Function(SortCondition) onTap;
  const _GenresPanel({this.genres, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(40), vertical: Adapt.px(40)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Genres',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: Adapt.px(30)),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: genres
                .map(
                  (e) => SizedBox(
                    child: _TapCell<SortCondition>(
                      title: e.name.replaceAll('_', ' '),
                      value: e,
                      selected: e.isSelected,
                      onTap: onTap,
                    ),
                  ),
                )
                .toList())
      ]),
    );
  }
}

class _VoteFilterPanel extends StatefulWidget {
  final double lvote;
  final double rvote;
  final Function(double, double) onChange;
  const _VoteFilterPanel({this.onChange, this.lvote, this.rvote});
  @override
  _VoteFilterPanelState createState() => _VoteFilterPanelState();
}

class _VoteFilterPanelState extends State<_VoteFilterPanel> {
  double lvote = 0.0;
  double rvote = 10.0;
  final _totalWidth = Adapt.screenW() - Adapt.px(80);
  final double _pinWidth = 18.0;
  final double _lineHeight = 8;
  double _linerPadding;
  double _barSpace;
  double _leftMargin = 0.0;
  double _rightMargin = 0.0;

  void _leftPinDrag(DragUpdateDetails d) {
    _leftMargin += d.primaryDelta;
    if (_leftMargin < 0)
      _leftMargin = 0.0;
    else if (_barSpace - _rightMargin - _leftMargin < 0)
      _leftMargin = _barSpace - _rightMargin;
    lvote = (_leftMargin / _totalWidth) * 10;
    widget.onChange(lvote, rvote);
    setState(() {});
  }

  void _rightPinDrag(DragUpdateDetails d) {
    _rightMargin -= d.primaryDelta;
    if (_rightMargin < 0)
      _rightMargin = 0.0;
    else if (_barSpace - _rightMargin - _leftMargin < 0)
      _rightMargin = _barSpace - _leftMargin;

    rvote = 10 - (_rightMargin / _totalWidth) * 10;
    widget.onChange(lvote, rvote);
    setState(() {});
  }

  @override
  void initState() {
    _linerPadding = (_pinWidth - _lineHeight) / 2;
    lvote = widget.lvote;
    rvote = widget.rvote;
    _barSpace = _totalWidth - _pinWidth * 2;
    _leftMargin = lvote / 10 * _barSpace;
    _rightMargin = (10 - rvote) / 10 * _barSpace;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(40), vertical: Adapt.px(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'User Score',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: Adapt.px(30)),
        Container(
          child: Stack(children: [
            Container(
              height: _lineHeight,
              margin: EdgeInsets.symmetric(vertical: _linerPadding),
              decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(Adapt.px(6))),
            ),
            Column(children: [
              Container(
                height: _lineHeight,
                margin: EdgeInsets.only(
                    right: _rightMargin,
                    left: _leftMargin,
                    top: _linerPadding,
                    bottom: _linerPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(7.5)),
                  gradient: LinearGradient(colors: [
                    const Color(0xFF556677),
                    const Color(0xFF334455),
                    const Color(0xFF556677),
                  ]),
                ),
              ),
              SizedBox(height: Adapt.px(15)),
              Row(children: [
                Text(
                  '${lvote.toStringAsFixed(1)}',
                  style: TextStyle(color: const Color(0xFF9E9E9E)),
                ),
                Spacer(),
                Text(
                  '${rvote.toStringAsFixed(1)}',
                  style: TextStyle(color: const Color(0xFF9E9E9E)),
                ),
              ])
            ]),
            Container(
              height: _pinWidth,
              margin: EdgeInsets.only(
                right: _rightMargin,
                left: _leftMargin,
              ),
              child: Row(children: [
                _Pin(
                  onDrap: _leftPinDrag,
                  pinSize: _pinWidth,
                  theme: _theme,
                ),
                Spacer(),
                _Pin(
                  onDrap: _rightPinDrag,
                  pinSize: _pinWidth,
                  theme: _theme,
                )
              ]),
            )
          ]),
        )
      ]),
    );
  }
}

class _Pin extends StatelessWidget {
  final double pinSize;
  final Function(DragUpdateDetails) onDrap;
  final ThemeData theme;
  const _Pin({this.onDrap, this.pinSize, this.theme});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: onDrap,
        child: Container(
          width: pinSize,
          height: pinSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF717171)),
            color: theme.backgroundColor,
          ),
        ));
  }
}
