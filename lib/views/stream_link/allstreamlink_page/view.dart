import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/sort_condition.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllStreamLinkPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      key: state.scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        brightness: _theme.brightness,
        backgroundColor: _theme.backgroundColor,
        iconTheme: _theme.iconTheme,
        title: Text(
          '${state.mediaType == MediaType.movie ? 'Movie' : 'TvShows'} Share',
          style: _theme.textTheme.bodyText1,
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
          _Menu(
            animationController: state.animationController,
            sortTypes: state.sortTypes,
            sortChanged: (e) =>
                dispatch(AllStreamLinkPageActionCreator.sortChanged(e)),
            submit: (s) => dispatch(AllStreamLinkPageActionCreator.search(s)),
          ),
          //_buildGridView()

          _GridView(
            dispatch: dispatch,
            list: state.mediaType == MediaType.movie
                ? state.movieList?.data
                : state.tvList?.data,
          ),
        ],
      ),
    );
  });
}

class _Menu extends StatelessWidget {
  final AnimationController animationController;
  final List<SortCondition<dynamic>> sortTypes;
  final Function(String) submit;
  final Function(SortCondition<dynamic>) sortChanged;
  const _Menu(
      {this.animationController,
      this.submit,
      this.sortChanged,
      this.sortTypes});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          return Container(
            color: _theme.backgroundColor,
            height: Tween<double>(begin: 0.0, end: Adapt.px(130))
                .animate(CurvedAnimation(
                  parent: animationController,
                  curve: Curves.ease,
                ))
                .value,
            child: Opacity(
              opacity: animationController.value,
              child: Row(
                children: <Widget>[
                  Container(
                    width: Adapt.screenW() - Adapt.px(160),
                    margin: EdgeInsets.all(Adapt.px(25)),
                    padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                    decoration: BoxDecoration(
                        color: _theme.primaryColorDark,
                        borderRadius: BorderRadius.circular(Adapt.px(35))),
                    child: TextField(
                      onSubmitted: (s) => submit(s),
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
                    onSelected: (selected) => sortChanged(selected),
                    itemBuilder: (ctx) {
                      return sortTypes.map((s) {
                        var unSelectedStyle = TextStyle(color: Colors.grey);
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
                              s.isSelected ? Icon(Icons.check) : SizedBox()
                            ],
                          ),
                        );
                      }).toList();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  final dynamic data;
  final Function(dynamic) onTap;
  const _GridCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        key: ValueKey(data),
        decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              ImageUrl.getUrl(data.photourl, ImageSize.w300),
            ),
          ),
        ),
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  final dynamic list;
  final Dispatch dispatch;
  const _GridView({this.dispatch, this.list});
  @override
  Widget build(BuildContext context) {
    return list == null
        ? SliverToBoxAdapter(
            child: Container(
              height: Adapt.px(400),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF505050)),
                ),
              ),
            ),
          )
        : SliverGrid.count(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3,
            children: list
                .map<Widget>(
                  (d) => _GridCell(
                    data: d,
                    onTap: (e) => dispatch(
                        AllStreamLinkPageActionCreator.gridCellTapped(
                            e.id, e.photourl, e.name, e.photourl)),
                  ),
                )
                .toList(),
          );
  }
}
