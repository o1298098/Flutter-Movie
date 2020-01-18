import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/tvdetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    TvInfoState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _getOverWatch() {
    Widget _child = state.overView == null
        ? SizedBox(
            child: Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: Adapt.px(60)),
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: Adapt.px(30),
                  ),
                ],
              ),
            ),
          ))
        : Text(state.overView,
            style: TextStyle(
                height: 1.2,
                fontSize: Adapt.px(30),
                fontWeight: FontWeight.w400));
    return Padding(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), Adapt.px(30), Adapt.px(30), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(I18n.of(viewService.context).overView,
              style: TextStyle(
                  fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
          SizedBox(
            height: Adapt.px(30),
          ),
          _child
        ],
      ),
    );
  }

  Widget _buildCreatorCell(CreatedBy d) {
    return Container(
      width: Adapt.px(350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            d.name,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
          ),
          Text(I18n.of(viewService.context).creator,
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)))
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (state.createdBy.length > 0)
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(Adapt.px(30)),
              child: Text(I18n.of(viewService.context).featuredCrew,
                  style: TextStyle(
                      fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
            ),
            Padding(
              padding: EdgeInsets.only(left: Adapt.px(30)),
              child: Wrap(
                runSpacing: Adapt.px(30),
                children: state.createdBy.map(_buildCreatorCell).toList(),
              ),
            )
          ],
        ),
      );
    else
      return Container();
  }

  Widget _buildCreditsCell(CastData p) {
    return GestureDetector(
      onTap: () => dispatch(TVDetailPageActionCreator.onCastCellTapped(
          p.id, p.profilePath, p.name)),
      child: Container(
        margin: EdgeInsets.only(left: Adapt.px(20)),
        width: Adapt.px(240),
        height: Adapt.px(400),
        child: Card(
          elevation: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'people' + p.id.toString(),
                child: Container(
                  width: Adapt.px(240),
                  height: Adapt.px(260),
                  decoration: BoxDecoration(
                      color: _theme.primaryColorLight,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              p.profilePath == null
                                  ? ImageUrl.emptyimage
                                  : ImageUrl.getUrl(
                                      p.profilePath, ImageSize.w300)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
                child: Hero(
                  tag: 'Actor' + p.id.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      p.name,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Adapt.px(20),
                    right: Adapt.px(20),
                    bottom: Adapt.px(20)),
                child: Text(
                  p.character,
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditsShimmerCell() {
    return SizedBox(
      width: Adapt.px(240),
      height: Adapt.px(480),
      child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              width: Adapt.px(240),
              height: Adapt.px(260),
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(15), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(20), 0),
              color: Colors.grey[200],
            ),
            Container(
              height: Adapt.px(24),
              margin: EdgeInsets.fromLTRB(
                  0, Adapt.px(5), Adapt.px(70), Adapt.px(20)),
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCreditsCells() {
    Widget _child = state.cast != null
        ? ListView(
            scrollDirection: Axis.horizontal,
            children: state.cast.map(_buildCreditsCell).toList(),
          )
        : ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(
                width: Adapt.px(30),
              ),
              _buildCreditsShimmerCell(),
              SizedBox(
                width: Adapt.px(30),
              ),
              _buildCreditsShimmerCell(),
              SizedBox(
                width: Adapt.px(30),
              ),
              _buildCreditsShimmerCell(),
            ],
          );
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Adapt.px(30)),
            child: Text(I18n.of(viewService.context).topBilledCast,
                style: TextStyle(
                    fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
          ),
          Container(height: Adapt.px(450), child: _child)
        ],
      ),
    );
  }

  return SliverToBoxAdapter(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        _getOverWatch(),
        _buildBody(),
        _getCreditsCells(),
      ]));
}
