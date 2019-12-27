import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllStreamLinkPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    Widget _buildMenu() {
      return SliverToBoxAdapter(
          child: AnimatedBuilder(
              animation: state.animationController,
              builder: (_, __) {
                return Container(
                    color: _theme.backgroundColor,
                    height: Tween<double>(begin: 0.0, end: Adapt.px(130))
                        .animate(CurvedAnimation(
                          parent: state.animationController,
                          curve: Curves.ease,
                        ))
                        .value,
                    child: Opacity(
                        opacity: state.animationController.value,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: Adapt.screenW() - Adapt.px(160),
                              margin: EdgeInsets.all(Adapt.px(25)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Adapt.px(30)),
                              decoration: BoxDecoration(
                                  color: _theme.primaryColorDark,
                                  borderRadius:
                                      BorderRadius.circular(Adapt.px(35))),
                              child: TextField(
                                onSubmitted: (s) => dispatch(
                                    AllStreamLinkPageActionCreator.search(s)),
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  hintStyle: TextStyle(fontSize: Adapt.px(35)),
                                  labelStyle: TextStyle(fontSize: Adapt.px(35)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0)),
                                  hintText: 'Search',
                                ),
                              ),
                            ),
                            PopupMenuButton<SortCondition>(
                              padding: EdgeInsets.zero,
                              offset: Offset(0, Adapt.px(100)),
                              icon: Icon(Icons.sort),
                              onSelected: (selected) => dispatch(
                                  AllStreamLinkPageActionCreator.sortChanged(
                                      selected)),
                              itemBuilder: (ctx) {
                                return state.sortTypes.map((s) {
                                  var unSelectedStyle =
                                      TextStyle(color: Colors.grey);
                                  var selectedStyle =
                                      TextStyle(fontWeight: FontWeight.bold);
                                  return PopupMenuItem<SortCondition>(
                                    value: s,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          s.name,
                                          style: s.isSelected
                                              ? selectedStyle
                                              : unSelectedStyle,
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        s.isSelected
                                            ? Icon(Icons.check)
                                            : SizedBox()
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            )
                          ],
                        )));
              }));
    }

    Widget _buildCell(dynamic d) {
      return GestureDetector(
        onTap: () => dispatch(AllStreamLinkPageActionCreator.gridCellTapped(
            d.id, d.photourl, d.name, d.photourl)),
        child: Container(
          key: ValueKey(d),
          decoration: BoxDecoration(
              color: _theme.primaryColorDark,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(d.photourl, ImageSize.w300)))),
        ),
      );
    }

    Widget _buildGridView() {
      var _list =
          state.mediaType == MediaType.movie ? state.movieList : state.tvList;
      return _list == null
          ? SliverToBoxAdapter(
              child: Container(
                  height: Adapt.px(400),
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xFF505050)),
                  ))))
          : SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              children: state.mediaType == MediaType.movie
                  ? state.movieList.data.map(_buildCell).toList()
                  : state.tvList.data.map(_buildCell).toList(),
            );
    }

    return Scaffold(
      key: state.scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        brightness: _theme.brightness,
        backgroundColor: _theme.backgroundColor,
        iconTheme: _theme.iconTheme,
        title: Text(
          '${state.mediaType == MediaType.movie ? 'Movie' : 'TvShows'} Share',
          style: _theme.textTheme.body1,
        ),
        actions: <Widget>[
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: state.animationController,
            ),
            onPressed: () {
              if (state.animationController.value == 0)
                state.animationController.forward();
              else
                state.animationController.reverse();
            },
          )
        ],
      ),
      body: CustomScrollView(
        controller: state.scrollController,
        slivers: <Widget>[
          _buildMenu(),
          _buildGridView(),
        ],
      ),
    );
  });
}
