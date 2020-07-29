import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/combined_credits.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/peopledetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../style/themestyle.dart';
import 'state.dart';

Widget buildView(
    KnownForState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: AnimatedSwitcher(
      key: ValueKey('knownfor'),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 600),
      child: Container(
        key: ValueKey(state.cast),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              child: Text(
                I18n.of(viewService.context).knownFor,
                softWrap: true,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: Adapt.px(40)),
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            _KownForList(
              cast: state.cast,
              dispatch: dispatch,
            ),
          ],
        ),
      ),
    ),
  );
}

class _ShimmerCell extends StatelessWidget {
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
            height: Adapt.px(342),
          ),
          Container(
            height: Adapt.px(24),
            margin: EdgeInsets.fromLTRB(0, Adapt.px(15), Adapt.px(20), 0),
            color: Colors.grey[200],
          ),
          Container(
            height: Adapt.px(24),
            margin:
                EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(50), Adapt.px(20)),
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            itemBuilder: (_, __) => _ShimmerCell(),
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(20)),
            itemCount: 3));
  }
}

class _KownForCell extends StatelessWidget {
  final Function onTap;
  final CastData data;
  const _KownForCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
        key: ValueKey('knowforCell${data.id}'),
        onTap: onTap,
        child: Container(
          width: Adapt.px(240),
          height: Adapt.px(400),
          child: Card(
            elevation: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(240),
                  height: Adapt.px(342),
                  decoration: BoxDecoration(
                      color: _theme.primaryColorLight,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(data.posterPath, ImageSize.w300)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Adapt.px(15),
                      left: Adapt.px(20),
                      right: Adapt.px(20)),
                  child: Text(
                    data.title ?? data.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: Adapt.px(26)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class _KownForList extends StatelessWidget {
  final List<CastData> cast;
  final Dispatch dispatch;
  const _KownForList({this.cast, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(480),
      child: cast.length > 0
          ? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(20)),
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, index) {
                final _d = cast[index];
                return _KownForCell(
                  data: _d,
                  onTap: () => dispatch(
                      PeopleDetailPageActionCreator.onCellTapped(
                          _d.id,
                          _d.backdropPath,
                          _d.title ?? _d.name,
                          _d.posterPath,
                          _d.mediaType == 'movie'
                              ? MediaType.movie
                              : MediaType.person)),
                );
              },
            )
          : _ShimmerList(),
    );
  }
}
