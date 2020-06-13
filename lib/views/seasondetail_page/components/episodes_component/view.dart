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
              itemBuilder: (_, i) => _EpisodeCell2(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: Adapt.screenW() - Adapt.px(60),
          height: (Adapt.screenW() - Adapt.px(60)) * 9 / 16,
          color: Colors.grey[200],
        ),
        Container(
          margin: EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(20)),
          width: Adapt.px(150),
          height: Adapt.px(24),
          color: Colors.grey[200],
        ),
        SizedBox(
          height: Adapt.px(20),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: Adapt.px(20),
            ),
            Container(
              width: Adapt.px(90),
              height: Adapt.px(45),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(Adapt.px(25))),
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Container(
              color: Colors.grey[200],
              width: Adapt.px(400),
              height: Adapt.px(30),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              left: Adapt.px(20), bottom: Adapt.px(8), top: Adapt.px(20)),
          color: Colors.grey[200],
          width: Adapt.screenW() - Adapt.px(100),
          height: Adapt.px(24),
        ),
        Container(
          margin: EdgeInsets.only(left: Adapt.px(20), bottom: Adapt.px(8)),
          color: Colors.grey[200],
          width: Adapt.screenW() - Adapt.px(100),
          height: Adapt.px(24),
        ),
        Container(
          margin: EdgeInsets.only(left: Adapt.px(20), bottom: Adapt.px(8)),
          color: Colors.grey[200],
          width: Adapt.screenW() - Adapt.px(100),
          height: Adapt.px(24),
        ),
        Container(
          margin: EdgeInsets.only(left: Adapt.px(20), bottom: Adapt.px(8)),
          color: Colors.grey[200],
          width: Adapt.screenW() - Adapt.px(300),
          height: Adapt.px(24),
        )
      ],
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
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          separatorBuilder: (_, __) => SizedBox(height: Adapt.px(30)),
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
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      key: ValueKey(data.id),
      child: GestureDetector(
        onTap: () => onTap(data),
        child: Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: 'pic' + data.episodeNumber.toString(),
                  child: Container(
                    width: Adapt.screenW() - Adapt.px(40),
                    height: (Adapt.screenW() - Adapt.px(40)) * 9 / 16,
                    decoration: BoxDecoration(
                      color: _theme.primaryColorDark,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          data.stillPath == null
                              ? ImageUrl.emptyimage
                              : ImageUrl.getUrl(data.stillPath, ImageSize.w300),
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'episodeDate' + data.episodeNumber.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        height: Adapt.px(50),
                        padding: EdgeInsets.fromLTRB(Adapt.px(20), Adapt.px(10),
                            Adapt.px(20), Adapt.px(10)),
                        child: Text(
                          DateFormat.yMMMd().format(
                              DateTime.parse(data.airDate ?? '1990-01-01')),
                          style: TextStyle(fontSize: Adapt.px(24)),
                        )),
                  ),
                ),
                Hero(
                  tag: 'episodetitle' + data.episodeNumber.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Adapt.px(20),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(Adapt.px(10),
                              Adapt.px(5), Adapt.px(15), Adapt.px(5)),
                          height: Adapt.px(45),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.circular(Adapt.px(25))),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: Adapt.px(25),
                              ),
                              SizedBox(
                                width: Adapt.px(5),
                              ),
                              Text(
                                data.voteAverage.toStringAsFixed(1),
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Adapt.px(20),
                        ),
                        Container(
                          width: Adapt.screenW() - Adapt.px(230),
                          child: Text(
                            '${data.episodeNumber}  ${data.name}',
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Hero(
                  tag: 'episodeoverWatch' + data.episodeNumber.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(Adapt.px(20), Adapt.px(10),
                          Adapt.px(20), Adapt.px(20)),
                      child: Text(data.overview ?? '-'),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _EpisodeCell2 extends StatelessWidget {
  final Episode data;
  final Function(Episode) onTap;
  const _EpisodeCell2({this.data, this.onTap});
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
          Container(
            height: Adapt.px(220),
            width: Adapt.px(400),
            transform:
                Matrix4.translationValues(-Adapt.px(40), -Adapt.px(40), 0),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                boxShadow: [
                  BoxShadow(
                      color: _shadowColor,
                      offset: Offset(Adapt.px(10), Adapt.px(20)),
                      blurRadius: Adapt.px(30),
                      spreadRadius: -Adapt.px(10))
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(data.stillPath, ImageSize.w300),
                  ),
                )),
          ),
          Text(
            data.name,
            style:
                TextStyle(fontSize: Adapt.px(26), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Adapt.px(10)),
          Text(data.overview),
          SizedBox(height: Adapt.px(50)),
        ],
      ),
    );
  }
}
