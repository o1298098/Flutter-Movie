import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/models.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/peopledetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

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
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 160,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            width: 100,
            height: 140,
          ),
          Container(
            height: 10,
            margin: EdgeInsets.fromLTRB(0, 8, 8, 0),
            color: Colors.grey[200],
          ),
          Container(
            height: 10,
            margin: EdgeInsets.fromLTRB(0, 5, 30, 0),
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        itemBuilder: (_, __) => const _ShimmerCell(),
        separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
        itemCount: 3,
      ),
    );
  }
}

class _KownForCell extends StatelessWidget {
  final Function onTap;
  final CombinedCastData data;
  const _KownForCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      key: ValueKey('knowforCell${data.id}'),
      onTap: onTap,
      child: Container(
        width: 100,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _theme.primaryColorLight,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(data.posterPath, ImageSize.w300)),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                data.title ?? data.name,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _KownForList extends StatelessWidget {
  final List<CombinedCastData> cast;
  final Dispatch dispatch;
  const _KownForList({this.cast, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: cast.length > 0
          ? ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
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
                          : MediaType.person,
                    ),
                  ),
                );
              },
            )
          : const _ShimmerList(),
    );
  }
}
