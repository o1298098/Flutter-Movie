import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PeopleDetailPageState state, Dispatch dispatch, ViewService viewService) {
  //var adapter = viewService.buildAdapter();
  return Scaffold(
    //backgroundColor: Colors.grey[100],
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          CustomScrollView(
            slivers: [
              viewService.buildComponent('header'),
              viewService.buildComponent('personalInfo'),
              viewService.buildComponent('knowFor'),
              viewService.buildComponent('gallery'),
              _ActionTitle(
                title: state.peopleDetailModel?.knownForDepartment ?? 'Acting',
                showMovie: state.showmovie,
                onTap: (b) =>
                    dispatch(PeopleDetailPageActionCreator.showMovie(b)),
              ),
              viewService.buildComponent('timeline'),
              SliverToBoxAdapter(
                child: const SizedBox(height: 20),
              )
            ],
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 20),
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black38),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(viewService.context).pop(),
                icon: Icon(
                  Icons.close,
                  size: 20,
                ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ActionTitle extends StatelessWidget {
  final String title;
  final bool showMovie;
  final Function(bool) onTap;
  const _ActionTitle({this.title, this.onTap, this.showMovie});
  @override
  Widget build(BuildContext context) {
    final _selectTextStyle = TextStyle(fontWeight: FontWeight.w500);
    final _unSelectTextStyle = TextStyle(color: Colors.grey);
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _Title(department: title),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: () => onTap(true),
              child: Text(I18n.of(context).movies,
                  style: showMovie ? _selectTextStyle : _unSelectTextStyle),
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            GestureDetector(
              onTap: () => onTap(false),
              child: Text(I18n.of(context).tvShows,
                  style: showMovie ? _unSelectTextStyle : _selectTextStyle),
            )
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String department;
  const _Title({this.department});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return department == null
        ? SizedBox(
            child: Shimmer.fromColors(
              baseColor: _theme.primaryColorDark,
              highlightColor: _theme.primaryColorLight,
              child: Container(
                height: Adapt.px(40),
                width: Adapt.px(150),
                color: Colors.grey[200],
              ),
            ),
          )
        : Text(
            department ?? '',
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          );
  }
}
