import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/genre.dart';
import 'package:movie/models/production_companie.dart';
import 'package:movie/widgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/releasedatetype.dart';
import 'package:movie/models/release_date_model.dart';

import 'dart:ui' as ui;

import 'action.dart';
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

  Widget _buildProductionCompanieCell(ProductionCompanie d) {
    if (d.logoPath != null)
      return Container(
        margin: EdgeInsets.only(bottom: Adapt.px(20)),
        width: Adapt.px(120),
        height: Adapt.px(60),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(d.logoPath, ImageSize.w300)))),
      );
    else
      return Container();
  }

  Widget _buildReleaseDateCell(ReleaseDateInfo d) {
    return Container(
      padding: EdgeInsets.only(bottom: Adapt.px(20)),
      width: Adapt.px(320),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  DateFormat.yMMMd()
                      .format(DateTime.tryParse(d.releaseDate ?? '1900-01-01')),
                  style: TextStyle(fontSize: Adapt.px(24))),
              SizedBox(
                height: Adapt.px(5),
              ),
              Row(
                children: <Widget>[
                  d.certification != ''
                      ? Container(
                          margin: EdgeInsets.only(right: Adapt.px(10)),
                          padding: EdgeInsets.all(Adapt.px(8)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Adapt.px(10)),
                              color: Colors.black87),
                          child: Text(d.certification,
                              style: TextStyle(
                                  fontSize: Adapt.px(20), color: Colors.white)),
                        )
                      : Container(),
                  Container(
                    width: Adapt.px(150),
                    child: Text(
                      ReleaseDateType.releaseDateType[d.type],
                      style: TextStyle(fontSize: Adapt.px(24)),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _getReleaseDate() {
    if (state.movieDetailModel?.releaseDates != null) {
      var q = state?.movieDetailModel?.releaseDates?.results
          ?.where((d) => d.iso31661 == ui.window.locale.countryCode)
          ?.toList();
      ReleaseDateResult data;
      if (q != null && q.length > 0) {
        data = q.first;
        return Wrap(
            spacing: Adapt.px(20),
            children: data.releaseDates.map(_buildReleaseDateCell).toList());
      }
    }
    return Wrap(
      spacing: Adapt.px(40),
      children: <Widget>[
        ShimmerCell(Adapt.px(120), Adapt.px(60), 0),
        ShimmerCell(Adapt.px(120), Adapt.px(60), 0)
      ],
    );
  }

  Widget _getExternal() {
    var d = state.movieDetailModel.externalIds;
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
          (d.facebookId == null &&
                      d.twitterId == null &&
                      d.instagramId == null) ||
                  state.movieDetailModel.homepage == null
              ? Container()
              : Container(
                  width: Adapt.px(2),
                  height: Adapt.px(50),
                  color: Colors.grey,
                ),
          SizedBox(
            width: Adapt.px(20),
          ),
          state.movieDetailModel.homepage != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(Adapt.px(30)),
                  onTap: () => dispatch(InfoActionCreator.onExternalTapped(
                      state.movieDetailModel.homepage)),
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
    final moneyformat = new NumberFormat("###,###");
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
                I18n.of(viewService.context).company,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(30),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Adapt.px(10)),
              Wrap(
                spacing: Adapt.px(40),
                children: state.movieDetailModel?.productionCompanies != null
                    ? state.movieDetailModel.productionCompanies
                        .map(_buildProductionCompanieCell)
                        .toList()
                    : <Widget>[
                        ShimmerCell(Adapt.px(120), Adapt.px(60), 0),
                        ShimmerCell(Adapt.px(120), Adapt.px(60), 0)
                      ],
              )
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(viewService.context).releaseInformation,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(30),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Adapt.px(10)),
              _getReleaseDate()
            ],
          ),
          Row(
            children: <Widget>[
              _buildInfoCell(I18n.of(viewService.context).status,
                  state.movieDetailModel?.status),
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Row(
            children: <Widget>[
              _buildInfoCell(I18n.of(viewService.context).originalLanguage,
                  state.movieDetailModel?.originalLanguage),
              _buildInfoCell(
                  I18n.of(viewService.context).runtime,
                  state.movieDetailModel.runtime == null
                      ? 'none'
                      : state.movieDetailModel.runtime.toString() + 'M'),
            ],
          ),
          SizedBox(
            height: Adapt.px(10),
          ),
          Row(
            children: <Widget>[
              _buildInfoCell(
                  I18n.of(viewService.context).budget,
                  '\$' +
                      moneyformat.format(state.movieDetailModel?.budget ?? 0)),
              _buildInfoCell(
                  I18n.of(viewService.context).revenue,
                  "\$" +
                      moneyformat.format(state.movieDetailModel?.revenue ?? 0)),
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
                children: state.movieDetailModel?.genres != null
                    ? state.movieDetailModel.genres
                        .map(_buildGenderCell)
                        .toList()
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
