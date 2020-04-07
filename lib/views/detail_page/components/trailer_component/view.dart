import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/videomodel.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TrailerState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
      child: SizedBox(
    height: Adapt.px(395),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        child: Text(
          'Trailers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(35)),
        ),
      ),
      SizedBox(
        height: Adapt.px(350),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: (state.videos?.results?.length ?? 0) > 0
              ? ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.px(40), Adapt.px(30), Adapt.px(40), 0),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
                  itemCount: state?.videos?.results?.length ?? 0,
                  itemBuilder: (_, index) {
                    final d = state.videos.results[index];
                    return _TrailerCell(
                      data: d,
                      onTap: () =>
                          dispatch(TrailerActionCreator.playTrailer(d.key)),
                    );
                  },
                )
              : _ShimmerList(),
        ),
      ),
    ]),
  ));
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Adapt.px(320),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: Adapt.px(180),
            width: Adapt.px(320),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(Adapt.px(15)),
            ),
          ),
          SizedBox(height: Adapt.px(15)),
          Container(
            width: Adapt.px(200),
            height: Adapt.px(24),
            color: const Color(0xFFEEEEEE),
          )
        ]));
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        key: ValueKey('trailerListShimmer'),
        child: ListView.separated(
          padding:
              EdgeInsets.fromLTRB(Adapt.px(40), Adapt.px(30), Adapt.px(40), 0),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
          itemCount: 3,
          itemBuilder: (_, index) => _ShimmerCell(),
        ),
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight);
  }
}

class _TrailerCell extends StatelessWidget {
  final VideoResult data;
  final Function onTap;
  const _TrailerCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
            width: Adapt.px(320),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(children: [
                Container(
                  height: Adapt.px(180),
                  width: Adapt.px(320),
                  decoration: BoxDecoration(
                    color: _theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(Adapt.px(15)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            'https://i.ytimg.com/vi/${data.key}/hqdefault.jpg')),
                  ),
                ),
                Container(
                  height: Adapt.px(180),
                  width: Adapt.px(320),
                  decoration: BoxDecoration(
                    color: const Color(0x55000000),
                    borderRadius: BorderRadius.circular(Adapt.px(15)),
                  ),
                  child: Icon(
                    Icons.play_circle_outline,
                    size: Adapt.px(80),
                    color: const Color(0xFFFFFFFF),
                  ),
                )
              ]),
              SizedBox(height: Adapt.px(15)),
              Text(
                data.name,
                maxLines: 2,
                style: TextStyle(
                    fontSize: Adapt.px(24), fontWeight: FontWeight.w500),
              )
            ])));
  }
}
