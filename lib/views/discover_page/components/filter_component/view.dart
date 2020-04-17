import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/style/themestyle.dart';

import '../../action.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    FilterState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    return Container(
      key: GlobalKey(),
      padding: EdgeInsets.fromLTRB(Adapt.px(30), Adapt.px(30), Adapt.px(30), 0),
      //color: Colors.white,
      child: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                color: _theme.primaryColorDark,
              ),
              child: TextField(
                  controller: state.keyWordController,
                  keyboardAppearance: Brightness.light,
                  cursorColor: Colors.grey,
                  onSubmitted: (v) {
                    viewService
                        .broadcast(DiscoverPageActionCreator.onRefreshData());
                  },
                  decoration: new InputDecoration(
                      hintText: "KeyWords",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      enabledBorder: new UnderlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.transparent)),
                      focusedBorder: new UnderlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.transparent)))),
            ),
            SizedBox(height: Adapt.px(20)),
            Text(
              'Type',
              style: TextStyle(
                  fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
            ),
            SizedBox(height: Adapt.px(20)),
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                      alignment: Alignment.center,
                      width: Adapt.px(120),
                      padding: EdgeInsets.all(Adapt.px(10)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(10)),
                          border: Border.all(
                              color: state.isMovie
                                  ? _theme.textTheme.bodyText1.color
                                  : Colors.grey)),
                      child: Text(
                        'Movie',
                        style: TextStyle(
                            color: state.isMovie
                                ? _theme.textTheme.bodyText1.color
                                : Colors.grey),
                      )),
                  onTap: () {
                    dispatch(FilterActionCreator.onSortChanged(true));
                    viewService
                        .broadcast(DiscoverPageActionCreator.onRefreshData());
                  },
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: Adapt.px(120),
                    padding: EdgeInsets.all(Adapt.px(10)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.px(10)),
                        border: Border.all(
                            color: state.isMovie
                                ? Colors.grey
                                : _theme.textTheme.bodyText1.color)),
                    child: Text('TV',
                        style: TextStyle(
                            color: state.isMovie
                                ? Colors.grey
                                : _theme.textTheme.bodyText1.color)),
                  ),
                  onTap: () {
                    // Navigator.pop(viewService.context);
                    dispatch(FilterActionCreator.onSortChanged(false));
                    viewService
                        .broadcast(DiscoverPageActionCreator.onRefreshData());
                  },
                ),
              ],
            ),
            SizedBox(height: Adapt.px(20)),
            Text(
              'Genres',
              style: TextStyle(
                  fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: Adapt.px(10),
              children: state.isMovie
                  ? state.movieGenres
                      .map((e) => _GernesCell(
                            data: e,
                            dispatch: dispatch,
                            viewService: viewService,
                          ))
                      .toList()
                  : state.tvGenres
                      .map((e) => _GernesCell(
                            data: e,
                            dispatch: dispatch,
                            viewService: viewService,
                          ))
                      .toList(),
            )
          ],
        ),
      ),
    );
  });
}

class _GernesCell extends StatelessWidget {
  final SortCondition data;
  final Dispatch dispatch;
  final ViewService viewService;
  _GernesCell({this.data, this.dispatch, this.viewService});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return ChoiceChip(
      label: Text(data.name),
      selected: data.isSelected,
      selectedColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      labelStyle: TextStyle(
          color:
              data.isSelected ? _theme.textTheme.bodyText1.color : Colors.grey),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(10)),
          side: BorderSide(
              color: data.isSelected
                  ? _theme.textTheme.bodyText1.color
                  : Colors.grey)),
      onSelected: (s) {
        data.isSelected = s;
        //Navigator.pop(viewService.context);
        dispatch(FilterActionCreator.onGenresChanged());
        viewService.broadcast(DiscoverPageActionCreator.onRefreshData());
      },
    );
  }
}
