import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/mylistmodel.dart';
import 'dart:ui' as ui;

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyListsPageState state, Dispatch dispatch, ViewService viewService) {
  var animate = TweenSequence([
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: 0.003, end: 0.0), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: -0.003, end: 0.0), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: 0.003, end: 0.0), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: -0.003, end: 0.0), weight: 1),
  ]);

  Widget _buildListCell(UserList d) {
    var date = DateTime.parse(d.updateTime);
    return RotationTransition(
      turns: animate.animate(CurvedAnimation(
          parent: state.cellAnimationController, curve: Curves.ease)),
      child: GestureDetector(
        onTap: () {
          if (!state.isEdit) dispatch(MyListsPageActionCreator.cellTapped(d));
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
          child: Container(
            height: Adapt.px(400),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(30)),
                color: Colors.grey[200],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(d.backGroundUrl))),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(30)),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          d.listName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adapt.px(45),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: Adapt.px(15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('${d.itemCount} Items',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Adapt.px(30),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            SizedBox(
                              width: Adapt.px(20),
                            ),
                            Container(
                              padding: EdgeInsets.all(Adapt.px(8)),
                              decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius:
                                      BorderRadius.circular(Adapt.px(10))),
                              child: Text(
                                'PUBLIC',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adapt.px(24)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Adapt.px(8),
                        ),
                        Text(
                          'Updated ' +
                              TimelineUtil.format(
                                date.millisecondsSinceEpoch,
                                locTimeMillis:
                                    DateTime.now().millisecondsSinceEpoch,
                                locale: ui.window.locale.languageCode,
                              ),
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: Adapt.px(28),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    state.isEdit
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () => dispatch(
                                    MyListsPageActionCreator.deleteList(d)),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () => dispatch(
                                    MyListsPageActionCreator.createList(
                                        d: {'list': d})),
                              ),
                            ],
                          )
                        : Container()
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildListShimmerCell() {
    return Container(
      margin: EdgeInsets.only(
          top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
      child: ShimmerCell(Adapt.screenW(), Adapt.px(400), Adapt.px(30)),
    );
  }

  Widget _buildAddCell() {
    return SizeTransition(
      sizeFactor: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          curve: Curves.ease, parent: state.animationController)),
      child: InkWell(
        onTap: () => dispatch(MyListsPageActionCreator.createList()),
        child: Container(
          margin: EdgeInsets.only(
              top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
          height: Adapt.px(400),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(Adapt.px(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.black,
                size: Adapt.px(50),
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              Text(
                'Create new list',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(35)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return FutureBuilder<UserListModel>(
      future: state.listData,
      builder: (BuildContext context, AsyncSnapshot<UserListModel> snapshot) {
        if (!snapshot.hasData)
          return SliverToBoxAdapter(
              child: Column(children: <Widget>[
            _buildListShimmerCell(),
            _buildListShimmerCell(),
            _buildListShimmerCell()
          ]));
        return SliverList(
          delegate: SliverChildListDelegate(
              snapshot.data.data.map(_buildListCell).toList()),
        );
      },
    );
  }

  return Builder(builder: (context) {
    final _lightTheme = ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black));
    final _darkTheme = ThemeData.dark().copyWith(
        backgroundColor: Color(0xFF303030),
        iconTheme: IconThemeData(color: Colors.white));
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = _mediaQuery.platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.backgroundColor,
          title: Text(
            'My Lists',
            style: _theme.textTheme.body1,
          ),
          brightness: _theme.brightness,
          iconTheme: _theme.iconTheme,
          actions: <Widget>[
            IconButton(
              icon: AnimatedSwitcher(
                child: state.isEdit
                    ? Icon(
                        Icons.check,
                        key: ValueKey(state.isEdit),
                      )
                    : Icon(Icons.edit, key: ValueKey(state.isEdit)),
                duration: Duration(milliseconds: 200),
              ),
              onPressed: () async {
                await state.scrollController.position.animateTo(0.0,
                    curve: Curves.ease, duration: Duration(milliseconds: 200));
                final r = !state.isEdit;
                if (r) {
                  await state.animationController.forward(from: 0.0);
                  state.cellAnimationController.repeat();
                  dispatch(MyListsPageActionCreator.onEdit(r));
                } else {
                  await state.animationController.reverse(from: 1.0);
                  state.cellAnimationController.reset();
                  dispatch(MyListsPageActionCreator.onEdit(r));
                }
              },
            ),
          ],
        ),
        body: CustomScrollView(
          controller: state.scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _buildAddCell(),
            ),
            _buildList(),
          ],
        ));
  });
}
