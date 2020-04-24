import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/externalidsmodel.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/tvdetail_page/components/info_component/action.dart';

import 'dart:ui' as ui;

import 'state.dart';

Widget buildView(InfoState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
      child: Container(
    padding: EdgeInsets.only(
        left: Adapt.px(30), right: Adapt.px(30), bottom: Adapt.px(70)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Externals(
          dispatch: dispatch,
          homePage: state.tvDetailModel.homepage,
          externalIds: state.tvDetailModel?.externalIds,
        ),
        _Facts(tvDetailModel: state.tvDetailModel),
      ],
    ),
  ));
}

class _InfoCell extends StatelessWidget {
  final String title;
  final String value;
  const _InfoCell({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.px(300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style:
                TextStyle(fontSize: Adapt.px(30), fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Adapt.px(8),
          ),
          value == null
              ? ShimmerCell(
                  Adapt.px(150),
                  Adapt.px(30),
                  0,
                  baseColor: _theme.primaryColorDark,
                  highlightColor: _theme.primaryColorLight,
                )
              : Text(
                  value,
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
                )
        ],
      ),
    );
  }
}

class _ExternalCell extends StatelessWidget {
  final String icon;
  final String url;
  final String id;
  final Dispatch dispatch;
  const _ExternalCell({this.icon, this.id, this.url, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return id != null
        ? InkWell(
            borderRadius: BorderRadius.circular(Adapt.px(30)),
            onTap: () => dispatch(InfoActionCreator.onExternalTapped(url + id)),
            child: Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              child: Image.asset(
                icon,
                color: _theme.iconTheme.color,
              ),
            ),
          )
        : SizedBox();
  }
}

class _GenderCell extends StatelessWidget {
  final Genre g;
  const _GenderCell({this.g});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Chip(
      elevation: 3.0,
      backgroundColor: _theme.cardColor,
      label: Text(g.name),
    );
  }
}

class _NetworkCell extends StatelessWidget {
  final NetWork data;
  const _NetworkCell({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Adapt.px(10)),
      width: Adapt.px(120),
      height: Adapt.px(60),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.scaleDown,
          image: CachedNetworkImageProvider(
            data.logoPath == null
                ? ImageUrl.emptyimage
                : ImageUrl.getUrl(data.logoPath, ImageSize.w300),
          ),
        ),
      ),
    );
  }
}

class _Certification extends StatelessWidget {
  final List<ContentRatingResult> q;
  const _Certification({this.q});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    ContentRatingResult d;
    if (q != null && q.length > 0) d = q.first;
    if (d != null)
      return Row(
        children: <Widget>[
          Container(
            width: Adapt.px(60),
            height: Adapt.px(40),
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topLeft,
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    'http://www.geonames.org/flags/x/${ui.window.locale.countryCode.toLowerCase()}.gif'),
              ),
            ),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Container(
            margin: EdgeInsets.only(right: Adapt.px(10)),
            padding: EdgeInsets.all(Adapt.px(8)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(10)),
                color: Colors.black87),
            child: Text(d.rating ?? '',
                style: TextStyle(fontSize: Adapt.px(20), color: Colors.white)),
          )
        ],
      );
    else
      return ShimmerCell(
        Adapt.px(80),
        Adapt.px(50),
        0,
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
      );
  }
}

class _Externals extends StatelessWidget {
  final ExternalIdsModel externalIds;
  final Dispatch dispatch;
  final String homePage;
  const _Externals({this.dispatch, this.externalIds, this.homePage});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final d = externalIds;
    if (d != null)
      return Row(
        children: <Widget>[
          _ExternalCell(
            icon: 'images/facebook_circle.png',
            url: 'https://www.facebook.com/',
            id: d.facebookId,
            dispatch: dispatch,
          ),
          SizedBox(width: Adapt.px(10)),
          _ExternalCell(
            icon: 'images/twitter_circle.png',
            url: 'https://twitter.com/',
            id: d.twitterId,
            dispatch: dispatch,
          ),
          SizedBox(width: Adapt.px(10)),
          _ExternalCell(
            icon: 'images/instagram_circle.png',
            url: 'https://www.instagram.com/',
            id: d.instagramId,
            dispatch: dispatch,
          ),
          SizedBox(width: Adapt.px(20)),
          d.facebookId == null && d.twitterId == null && d.instagramId == null
              ? Container()
              : Container(
                  width: Adapt.px(2),
                  height: Adapt.px(50),
                  color: Colors.grey,
                ),
          SizedBox(width: Adapt.px(20)),
          homePage != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(Adapt.px(30)),
                  onTap: () =>
                      dispatch(InfoActionCreator.onExternalTapped(homePage)),
                  child: Container(
                    width: Adapt.px(40),
                    height: Adapt.px(40),
                    child: Image.asset(
                      'images/link_bold.png',
                      color: _theme.iconTheme.color,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    else
      return Row(
        children: <Widget>[
          ShimmerCell(
            Adapt.px(60),
            Adapt.px(60),
            Adapt.px(30),
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          ShimmerCell(
            Adapt.px(60),
            Adapt.px(60),
            Adapt.px(30),
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          ShimmerCell(
            Adapt.px(60),
            Adapt.px(60),
            Adapt.px(30),
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
          )
        ],
      );
  }
}

class _Facts extends StatelessWidget {
  final TVDetailModel tvDetailModel;
  const _Facts({this.tvDetailModel});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: Adapt.px(30)),
          Text(
            I18n.of(context).facts,
            style:
                TextStyle(fontSize: Adapt.px(40), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Adapt.px(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(context).network,
                style: TextStyle(
                    fontSize: Adapt.px(30), fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Adapt.px(10)),
              Wrap(
                spacing: Adapt.px(40),
                children: tvDetailModel?.networks != null
                    ? tvDetailModel.networks
                        .map((d) => _NetworkCell(data: d))
                        .toList()
                    : <Widget>[
                        ShimmerCell(
                          Adapt.px(120),
                          Adapt.px(60),
                          0,
                          baseColor: _theme.primaryColorDark,
                          highlightColor: _theme.primaryColorLight,
                        ),
                        ShimmerCell(
                          Adapt.px(120),
                          Adapt.px(60),
                          0,
                          baseColor: _theme.primaryColorDark,
                          highlightColor: _theme.primaryColorLight,
                        )
                      ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Certification',
                style: TextStyle(
                    fontSize: Adapt.px(30), fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Adapt.px(10)),
              _Certification(
                  q: tvDetailModel?.contentRatings?.results
                      ?.where((d) => d.iso31661 == ui.window.locale.countryCode)
                      ?.toList())
            ],
          ),
          SizedBox(height: Adapt.px(10)),
          Row(
            children: <Widget>[
              _InfoCell(
                  title: I18n.of(context).status, value: tvDetailModel?.status),
              _InfoCell(
                  title: I18n.of(context).type, value: tvDetailModel?.type),
            ],
          ),
          SizedBox(height: Adapt.px(10)),
          Row(
            children: <Widget>[
              _InfoCell(
                  title: I18n.of(context).originalLanguage,
                  value: tvDetailModel?.originalLanguage),
              _InfoCell(
                  title: I18n.of(context).runtime,
                  value: tvDetailModel.episodeRunTime == null ||
                          tvDetailModel.episodeRunTime?.length == 0
                      ? 'none'
                      : tvDetailModel.episodeRunTime[0].toString() + 'M'),
            ],
          ),
          SizedBox(height: Adapt.px(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(context).genders,
                style: TextStyle(
                    fontSize: Adapt.px(30), fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: Adapt.px(20),
                children: tvDetailModel?.genres != null
                    ? tvDetailModel.genres
                        .map((d) => _GenderCell(g: d))
                        .toList()
                    : <Widget>[
                        ShimmerCell(
                          Adapt.px(100),
                          Adapt.px(50),
                          Adapt.px(25),
                          baseColor: _theme.primaryColorDark,
                          highlightColor: _theme.primaryColorLight,
                        ),
                        ShimmerCell(
                          Adapt.px(120),
                          Adapt.px(50),
                          Adapt.px(25),
                          baseColor: _theme.primaryColorDark,
                          highlightColor: _theme.primaryColorLight,
                        ),
                        ShimmerCell(
                          Adapt.px(80),
                          Adapt.px(50),
                          Adapt.px(25),
                          baseColor: _theme.primaryColorDark,
                          highlightColor: _theme.primaryColorLight,
                        ),
                      ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
