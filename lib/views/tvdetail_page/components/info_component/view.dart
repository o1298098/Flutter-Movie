import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/views/tvdetail_page/components/info_component/action.dart';

import 'dart:ui' as ui;

import 'state.dart';

Widget buildView(InfoState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildInfoCell(String title, String value) {
    return Container(
      width: Adapt.px(300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(30),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Adapt.px(8),
          ),
          value == null
              ? ShimmerCell(Adapt.px(150), Adapt.px(30), 0)
              : Text(
                  value,
                  style:
                      TextStyle(color: Colors.black87, fontSize: Adapt.px(24)),
                )
        ],
      ),
    );
  }

  Widget _buildExternalCell(String icon, String url, String id) {
    return id != null
        ? InkWell(
            borderRadius: BorderRadius.circular(Adapt.px(30)),
            onTap: () => dispatch(InfoActionCreator.onExternalTapped(url + id)),
            child: Container(
              width: Adapt.px(60),
              height: Adapt.px(60),
              child: Image.asset(
                icon,
              ),
            ),
          )
        : Container();
  }

  Widget _buildGenderCell(Genre g) {
    return Chip(
      elevation: 3.0,
      backgroundColor: Colors.white,
      label: Text(g.name),
    );
  }

  Widget _buildNetworkCell(NetWork d) {
    return Container(
      margin: EdgeInsets.only(bottom: Adapt.px(10)),
      width: Adapt.px(120),
      height: Adapt.px(60),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.scaleDown,
              image: CachedNetworkImageProvider(d.logo_path == null
                  ? ImageUrl.emptyimage
                  : ImageUrl.getUrl(d.logo_path, ImageSize.w300)))),
    );
  }

  Widget _buildCertification() {
    var q = state?.tvDetailModel?.contentRatings?.results
        ?.where((d) => d.iso31661 == ui.window.locale.countryCode)
        ?.toList();
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
                        'http://www.geonames.org/flags/x/${ui.window.locale.countryCode.toLowerCase()}.gif'))),
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
      return ShimmerCell(Adapt.px(80), Adapt.px(50), 0);
  }

  Widget _getExternal() {
    var d = state.tvDetailModel.externalids;
    if (d != null)
      return Row(
        children: <Widget>[
          _buildExternalCell('images/facebook_circle.png',
              'https://www.facebook.com/', d.facebookId),
          SizedBox(
            width: Adapt.px(10),
          ),
          _buildExternalCell(
              'images/twitter_circle.png', 'https://twitter.com/', d.twitterId),
          SizedBox(
            width: Adapt.px(10),
          ),
          _buildExternalCell('images/instagram_circle.png',
              'https://www.instagram.com/', d.instagramId),
          SizedBox(
            width: Adapt.px(20),
          ),
          d.facebookId == null && d.twitterId == null && d.instagramId == null
              ? Container()
              : Container(
                  width: Adapt.px(2),
                  height: Adapt.px(50),
                  color: Colors.grey,
                ),
          SizedBox(
            width: Adapt.px(20),
          ),
          state.tvDetailModel.homepage != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(Adapt.px(30)),
                  onTap: () => dispatch(InfoActionCreator.onExternalTapped(
                      state.tvDetailModel.homepage)),
                  child: Container(
                    width: Adapt.px(40),
                    height: Adapt.px(40),
                    child: Image.asset(
                      'images/link_bold.png',
                    ),
                  ))
              : SizedBox(),
        ],
      );
    else
      return Row(
        children: <Widget>[
          ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30)),
          SizedBox(
            width: Adapt.px(20),
          ),
          ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30)),
          SizedBox(
            width: Adapt.px(20),
          ),
          ShimmerCell(Adapt.px(60), Adapt.px(60), Adapt.px(30))
        ],
      );
  }

  Widget _getFacts() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Adapt.px(30),
          ),
          Text(
            I18n.of(viewService.context).facts,
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(40),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(viewService.context).network,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(30),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Adapt.px(10)),
              Wrap(
                spacing: Adapt.px(40),
                children: state.tvDetailModel?.networks != null
                    ? state.tvDetailModel.networks
                        .map(_buildNetworkCell)
                        .toList()
                    : <Widget>[
                        ShimmerCell(Adapt.px(120), Adapt.px(60), 0),
                        ShimmerCell(Adapt.px(120), Adapt.px(60), 0)
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
                    color: Colors.black,
                    fontSize: Adapt.px(30),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Adapt.px(10)),
              _buildCertification()
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Row(
            children: <Widget>[
              _buildInfoCell(I18n.of(viewService.context).status,
                  state.tvDetailModel?.status),
              _buildInfoCell(
                  I18n.of(viewService.context).type, state.tvDetailModel?.type),
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Row(
            children: <Widget>[
              _buildInfoCell(I18n.of(viewService.context).originalLanguage,
                  state.tvDetailModel?.original_language),
              _buildInfoCell(
                  I18n.of(viewService.context).runtime,
                  state.tvDetailModel.episode_run_time == null ||
                          state.tvDetailModel.episode_run_time?.length == 0
                      ? 'none'
                      : state.tvDetailModel.episode_run_time[0].toString() +
                          'M'),
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(viewService.context).genders,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(30),
                    fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: Adapt.px(20),
                children: state.tvDetailModel?.genres != null
                    ? state.tvDetailModel.genres.map(_buildGenderCell).toList()
                    : <Widget>[
                        ShimmerCell(Adapt.px(100), Adapt.px(50), Adapt.px(25)),
                        ShimmerCell(Adapt.px(120), Adapt.px(50), Adapt.px(25)),
                        ShimmerCell(Adapt.px(80), Adapt.px(50), Adapt.px(25)),
                      ],
              )
            ],
          ),
        ],
      ),
    );
  }

  return Container(
    padding: EdgeInsets.only(
        left: Adapt.px(30), right: Adapt.px(30), bottom: Adapt.px(70)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getExternal(),
        _getFacts(),
      ],
    ),
  );
}
