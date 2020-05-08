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
  return SliverToBoxAdapter(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        _OverView(overView: state.overView),
        _Body(
          createdBy: state.createdBy,
        ),
        _CreditsCells(
          cast: state.cast,
          dispatch: dispatch,
        ),
      ]));
}

class _OverWatchShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SizedBox(
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
    ));
  }
}

class _OverView extends StatelessWidget {
  final String overView;
  const _OverView({this.overView});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Adapt.px(30), Adapt.px(30), Adapt.px(30), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(I18n.of(context).overView,
              style: TextStyle(
                  fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
          SizedBox(
            height: Adapt.px(30),
          ),
          overView == null
              ? _OverWatchShimmer()
              : Text(
                  overView,
                  style: TextStyle(
                      height: 1.2,
                      fontSize: Adapt.px(30),
                      fontWeight: FontWeight.w400),
                ),
        ],
      ),
    );
  }
}

class _CreatorCell extends StatelessWidget {
  final CreatedBy data;
  const _CreatorCell({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.px(350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
          ),
          Text(I18n.of(context).creator,
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)))
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<CreatedBy> createdBy;
  const _Body({this.createdBy});
  @override
  Widget build(BuildContext context) {
    return createdBy.length > 0
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Adapt.px(30)),
                  child: Text(I18n.of(context).featuredCrew,
                      style: TextStyle(
                          fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Adapt.px(30)),
                  child: Wrap(
                    runSpacing: Adapt.px(30),
                    children:
                        createdBy.map((d) => _CreatorCell(data: d)).toList(),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}

class _CreditsShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adapt.px(240),
      height: Adapt.px(480),
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
            margin:
                EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(70), Adapt.px(20)),
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}

class _CreditsShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          separatorBuilder: (context, index) => SizedBox(width: Adapt.px(30)),
          itemCount: 3,
          itemBuilder: (context, index) => _CreditsShimmerCell(),
        ));
  }
}

class _CreditsCell extends StatelessWidget {
  final CastData data;
  final Function(CastData) onTap;
  const _CreditsCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        width: Adapt.px(240),
        height: Adapt.px(400),
        child: Card(
          elevation: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'people' + data.id.toString(),
                child: Container(
                  width: Adapt.px(240),
                  height: Adapt.px(260),
                  decoration: BoxDecoration(
                    color: _theme.primaryColorLight,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        data.profilePath == null
                            ? ImageUrl.emptyimage
                            : ImageUrl.getUrl(data.profilePath, ImageSize.w300),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
                child: Hero(
                  tag: 'Actor' + data.id.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      data.name,
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
                  data.character,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Adapt.px(24),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CreditsCells extends StatelessWidget {
  final List<CastData> cast;
  final Dispatch dispatch;
  const _CreditsCells({this.cast, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Adapt.px(30)),
            child: Text(I18n.of(context).topBilledCast,
                style: TextStyle(
                    fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
          ),
          Container(
            height: Adapt.px(450),
            child: cast != null
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: Adapt.px(30)),
                    itemCount: cast.length,
                    itemBuilder: (context, index) => _CreditsCell(
                      data: cast[index],
                      onTap: (p) => dispatch(
                        TVDetailPageActionCreator.onCastCellTapped(
                            p.id, p.profilePath, p.name),
                      ),
                    ),
                  )
                : _CreditsShimmerList(),
          ),
        ],
      ),
    );
  }
}
