import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/searchresult.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/style/themestyle.dart';
import 'package:parallax_image/parallax_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TrendingPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    Widget _buildFilter() {
      final TextStyle _selectTS =
          TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(30));
      final TextStyle _unSelectTS = TextStyle(fontSize: Adapt.px(30));
      return SliverToBoxAdapter(
        child: AnimatedBuilder(
          animation: state.animationController,
          builder: (_, __) {
            return Container(
              width: Adapt.px(300),
              height: Tween<double>(begin: 0.0, end: Adapt.px(80))
                  .animate(CurvedAnimation(
                    parent: state.animationController,
                    curve: Curves.ease,
                  ))
                  .value,
              color: _theme.backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () =>
                        dispatch(TrendingPageActionCreator.dateChanged(true)),
                    child: Text('Today',
                        style: state.isToday ? _selectTS : _unSelectTS),
                  ),
                  SizedBox(
                    width: Adapt.px(50),
                  ),
                  InkWell(
                      onTap: () => dispatch(
                          TrendingPageActionCreator.dateChanged(false)),
                      child: Text(
                        'This Week',
                        style: state.isToday ? _unSelectTS : _selectTS,
                      )),
                  Expanded(
                    child: SizedBox(),
                  ),
                  FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: state.animationController,
                            curve: Interval(0.5, 1, curve: Curves.ease))),
                    child: PopupMenuButton<SortCondition>(
                      padding: EdgeInsets.zero,
                      offset: Offset(0, Adapt.px(100)),
                      icon: Icon(Icons.apps),
                      onSelected: (selected) => dispatch(
                          TrendingPageActionCreator.mediaTypeChanged(selected)),
                      itemBuilder: (ctx) {
                        return state.mediaTypes.map((s) {
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
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    }

    Widget _buildTredingCell(int index) {
      SearchResult d = state.trending.results[index];
      return GestureDetector(
        key: ValueKey('trendingCell$index'),
        onTap: () => dispatch(TrendingPageActionCreator.cellTapped(d)),
        child: Container(
          margin: EdgeInsets.only(
              bottom: Adapt.px(50), left: Adapt.px(30), right: Adapt.px(30)),
          decoration: BoxDecoration(
            color: _theme.cardColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: Adapt.px(15),
                  offset: Offset(Adapt.px(10), Adapt.px(15)),
                  color: _theme.primaryColorDark)
            ],
            borderRadius: BorderRadius.circular(Adapt.px(30)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Adapt.px(280),
                height: Adapt.px(280),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Adapt.px(30)),
                  child: Container(
                    color: _theme.primaryColorDark,
                    child: ParallaxImage(
                      //controller: state.controller,
                      extent: Adapt.px(280),
                      image: CachedNetworkImageProvider(ImageUrl.getUrl(
                          d.posterPath ?? d.profilePath, ImageSize.w300)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Adapt.px(50),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Text(
                    '${index + 1}',
                    style: TextStyle(
                        //color: Color(0xFF505050),
                        fontSize: Adapt.px(50),
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: Adapt.screenW() - Adapt.px(490),
                    child: Text(
                      d.title ?? d.name,
                      style: TextStyle(
                          // color: Colors.black,
                          fontSize: Adapt.px(28),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  SizedBox(
                      width: Adapt.screenW() - Adapt.px(490),
                      child: Text(
                        (d.genreIds ?? [])
                            .take(3)
                            .map((f) {
                              return Genres.genres[f];
                            })
                            .toList()
                            .join(' / '),
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: Adapt.px(22)),
                      ))
                ],
              ),
              Container(
                height: Adapt.px(280),
                child: IconButton(
                  padding: EdgeInsets.only(left: Adapt.px(20)),
                  iconSize: Adapt.px(40),
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildRefreshing() {
      return SliverToBoxAdapter(
          child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: state.refreshController,
          curve: Curves.ease,
        )),
        child: SizedBox(
          height: Adapt.px(5),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF505050)),
          ),
        ),
      ));
    }

    Widget _buildLoading() {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(_theme.iconTheme.color),
          ),
        ),
      );
    }

    Widget _buildList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
          return _buildTredingCell(index);
        }, childCount: state.trending.results.length),
      );
    }

    return Scaffold(
        appBar: AppBar(
          brightness: _theme.brightness,
          backgroundColor: _theme.backgroundColor,
          elevation: 0.0,
          iconTheme: _theme.iconTheme,
          title:
              Text('Trending', style: TextStyle(color: _theme.iconTheme.color)),
          actions: <Widget>[
            IconButton(
              alignment: Alignment.centerLeft,
              icon: AnimatedIcon(
                progress: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(state.animationController),
                icon: AnimatedIcons.menu_close,
              ),
              onPressed: () => dispatch(TrendingPageActionCreator.showFilter()),
            ),
          ],
        ),
        body: Container(
            child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: CustomScrollView(
            key: ValueKey(state.trending),
            physics: BouncingScrollPhysics(),
            controller: state.controller,
            slivers: <Widget>[
              _buildFilter(),
              _buildRefreshing(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Adapt.px(30),
                ),
              ),
              _buildList(),
              _buildLoading(),
            ],
          ),
        )));
  });
}
