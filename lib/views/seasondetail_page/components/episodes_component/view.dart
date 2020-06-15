import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/expandable_text.dart';
import 'package:movie/widgets/linear_progress_Indicator.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodesState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    key: ValueKey(state.episodes),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: Adapt.px(30)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: I18n.of(viewService.context).episodes,
                  style: TextStyle(
                      fontSize: Adapt.px(30), fontWeight: FontWeight.w600)),
              TextSpan(
                  text:
                      ' ${state.episodes != null ? state.episodes.length.toString() : ''}',
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
            ],
          ),
        ),
      ),
      state.episodes.length > 0
          ? ListView.separated(
              shrinkWrap: true,
              physics: PageScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: Adapt.px(40), vertical: Adapt.px(30)),
              separatorBuilder: (_, __) => SizedBox(height: Adapt.px(30)),
              itemCount: state.episodes.length,
              itemBuilder: (_, i) => _EpisodeCell(
                data: state.episodes[i],
                onTap: (d) => dispatch(EpisodesActionCreator.onCellTapped(d)),
              ),
            )
          : const _ShimmerList()
    ],
  );
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _color = const Color(0xFFFFFFFF);
    return Container(
      //height: Adapt.px(400),
      margin: EdgeInsets.only(
        top: Adapt.px(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: Adapt.px(220),
                width: Adapt.px(380),
                transform:
                    Matrix4.translationValues(-Adapt.px(40), -Adapt.px(40), 0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(Adapt.px(20)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Adapt.px(20),
                    width: Adapt.px(200),
                    color: _color,
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Container(
                    height: Adapt.px(20),
                    width: Adapt.px(100),
                    color: _color,
                  ),
                  SizedBox(height: Adapt.px(10)),
                ],
              )
            ],
          ),
          Container(
            height: Adapt.px(20),
            width: Adapt.px(120),
            color: _color,
          ),
          SizedBox(height: Adapt.px(10)),
          Container(
            height: Adapt.px(18),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(18),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(18),
            width: Adapt.px(320),
            color: _color,
          ),
          SizedBox(height: Adapt.px(10)),
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
      child: SizedBox(
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(40), vertical: Adapt.px(30)),
          separatorBuilder: (_, __) => SizedBox(height: Adapt.px(60)),
          itemCount: 3,
          itemBuilder: (_, __) => const _ShimmerCell(),
        ),
      ),
    );
  }
}

class _EpisodeCell extends StatelessWidget {
  final Episode data;
  final Function(Episode) onTap;
  const _EpisodeCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _shadowColor = _theme.brightness == Brightness.light
        ? const Color(0xFFE0E0E0)
        : const Color(0x00000000);
    return Container(
      //height: Adapt.px(400),
      margin: EdgeInsets.only(
        top: Adapt.px(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          boxShadow: [
            BoxShadow(
              color: _shadowColor,
              offset: Offset(Adapt.px(10), Adapt.px(20)),
              blurRadius: Adapt.px(30),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: Adapt.px(220),
                width: Adapt.px(380),
                transform:
                    Matrix4.translationValues(-Adapt.px(40), -Adapt.px(40), 0),
                decoration: BoxDecoration(
                    color: _theme.primaryColorDark,
                    borderRadius: BorderRadius.circular(Adapt.px(20)),
                    boxShadow: [
                      BoxShadow(
                          color: _shadowColor,
                          offset: Offset(Adapt.px(10), Adapt.px(20)),
                          blurRadius: Adapt.px(20),
                          spreadRadius: -Adapt.px(10))
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(data.stillPath, ImageSize.w300),
                      ),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EP ${data.episodeNumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Adapt.px(30),
                    ),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Text(
                    data.airDate == null
                        ? '-'
                        : DateFormat.yMMMd()
                            .format(DateTime.parse(data.airDate)),
                    style: TextStyle(
                      fontSize: Adapt.px(20),
                      color: const Color(0xFF717171),
                    ),
                  ),
                  SizedBox(height: Adapt.px(10)),
                  Row(children: [
                    LinearGradientProgressIndicator(
                      value: data.voteAverage / 10,
                      width: Adapt.px(120),
                    ),
                    SizedBox(width: Adapt.px(10)),
                    Text(
                      data.voteAverage.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: Adapt.px(18),
                        color: const Color(0xFF717171),
                      ),
                    )
                  ])
                ],
              )
            ],
          ),
          Text(
            data.name,
            style:
                TextStyle(fontSize: Adapt.px(26), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Adapt.px(10)),
          ExpandableText(
            data.overview,
            maxLines: 3,
            style: TextStyle(
              color: const Color(0xFF717171),
            ),
          ),
          SizedBox(height: Adapt.px(40)),
        ],
      ),
    );
  }
}
