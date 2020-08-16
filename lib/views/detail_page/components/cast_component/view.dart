import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/models.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/detail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(CastState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: Adapt.px(50)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: Text(
              I18n.of(viewService.context).topBilledCast,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adapt.px(28)),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          _CastList(
            data: state.cast,
            dispatch: dispatch,
          )
        ],
      ),
    ),
  );
}

class _CastShimmerCell extends StatelessWidget {
  final double width = Adapt.px(150);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(15)),
            color: const Color(0xFFEEEEEE),
          ),
        ),
        SizedBox(
          height: Adapt.px(10),
        ),
        Container(
          width: width,
          height: Adapt.px(24),
          color: const Color(0xFFEEEEEE),
        ),
        SizedBox(
          height: Adapt.px(10),
        ),
        Container(
          width: Adapt.px(100),
          height: Adapt.px(24),
          color: const Color(0xFFEEEEEE),
        )
      ],
    );
  }
}

class _CastShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: Adapt.px(30)),
          itemCount: 5,
          itemBuilder: (context, index) => _CastShimmerCell(),
        ));
  }
}

class _CastCell extends StatelessWidget {
  final CastData data;
  final Function onTap;
  const _CastCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final double width = Adapt.px(150);
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        key: ValueKey('Cast${data.id}'),
        children: <Widget>[
          Hero(
              tag: 'people${data.id}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(15)),
                      color: _theme.primaryColorDark,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(ImageUrl.getUrl(
                              data.profilePath, ImageSize.w300)))),
                ),
              )),
          SizedBox(
            height: Adapt.px(10),
          ),
          Container(
              width: width,
              child: Text(
                data.name ?? '',
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Container(
              width: width,
              child: Text(
                data.character ?? '',
                maxLines: 2,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
              ))
        ],
      ),
    );
  }
}

class _CastList extends StatelessWidget {
  final List<CastData> data;
  final Dispatch dispatch;
  const _CastList({this.data, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(300),
      child: data.length == 0
          ? _CastShimmerList()
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final d = data[index];
                return _CastCell(
                  data: d,
                  onTap: () => dispatch(
                    MovieDetailPageActionCreator.castCellTapped(
                        d.id, d.profilePath, d.name, d.character),
                  ),
                );
              },
            ),
    );
  }
}
