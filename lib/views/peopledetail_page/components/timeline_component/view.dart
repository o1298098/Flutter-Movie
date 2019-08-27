import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TimeLineState state, Dispatch dispatch, ViewService viewService) {
  List<CastData> _movies;
  List<CastData> _tvshows;
  void initList() {
    var _model = state.creditsModel.cast ?? [];
    _movies = _model.where((d) => d.media_type == 'movie').toList();
    _tvshows = _model.where((d) => d.media_type == 'tv').toList();
  }

  Widget _buildTitle() {
    if (state.department == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          height: Adapt.px(40),
          width: Adapt.px(150),
          color: Colors.grey[200],
        ),
      ));
    else
      return Text(
        state.department ?? '',
        softWrap: true,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: Adapt.px(40)),
      );
  }

  Widget _buildShimmerCell() {
    Color _baseColor = Colors.grey[200];
    return Shimmer.fromColors(
      baseColor: _baseColor,
      highlightColor: Colors.grey[100],
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Adapt.px(24),
                width: Adapt.px(500),
                color: _baseColor,
              ),
              SizedBox(
                height: Adapt.px(8),
              ),
              Container(
                height: Adapt.px(24),
                width: Adapt.px(150),
                color: _baseColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActingCell(CastData d, bool hasline) {
    double _leftwidth = (Adapt.screenW() - Adapt.px(120)) * 0.8;
    String date = d.media_type == 'movie' ? d.release_date : d.first_air_date;
    date = date == null || date?.isEmpty == true
        ? '-'
        : DateTime.parse(date).year.toString();
    return Column(
      key: ValueKey('timelineCell${d.credit_id}'),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: _leftwidth,
                  child: Text(d.title ?? d.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                    width: _leftwidth,
                    child: Text(
                        d?.character?.isEmpty == true || d.character == null
                            ? '-'
                            : d.character,
                        style: TextStyle(color: Color(0xFF505050))))
              ],
            ),
            Text(date)
          ],
        ),
        hasline ? SizedBox() : Divider()
      ],
    );
  }

  Widget _buildActingBody() {
    if (_movies == null || _tvshows == null) initList();
    var _data = state.showmovie ? _movies : _tvshows;
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      child: ListView(
          physics: PageScrollPhysics(),
          shrinkWrap: true,
          children: _data.length > 0
              ? _data
                  .map((f) =>
                      _buildActingCell(f, _data.indexOf(f) == _data.length - 1))
                  .toList()
              : <Widget>[
                  _buildShimmerCell(),
                  Divider(),
                  _buildShimmerCell(),
                  Divider(),
                  _buildShimmerCell(),
                  Divider(),
                  _buildShimmerCell(),
                  Divider(),
                  _buildShimmerCell(),
                ]),
    );
  }

  return Column(
      key: ValueKey('timeLine'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(
                Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () =>
                      dispatch(TimeLineActionCreator.onActingChanged(true)),
                  child: Text(I18n.of(viewService.context).movies,
                      style: TextStyle(
                          color: state.showmovie ? Colors.black : Colors.grey)),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                GestureDetector(
                  onTap: () =>
                      dispatch(TimeLineActionCreator.onActingChanged(false)),
                  child: Text(I18n.of(viewService.context).tvShows,
                      style: TextStyle(
                          color: state.showmovie ? Colors.grey : Colors.black)),
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          child: _buildActingBody(),
        ),
      ]);
}
