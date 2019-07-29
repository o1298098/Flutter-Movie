import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  String filter = state.showmovie ? "movie" : "tv";

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
            fontWeight: FontWeight.bold,
            fontSize: Adapt.px(40)),
      );
  }

  Widget _buildTimelineCell(CastData d) {
    String date = d.media_type == 'movie' ? d.release_date : d.first_air_date;
    date = date == null || date?.isEmpty == true
        ? '-'
        : DateTime.parse(date).year.toString();
    return Container(
        padding: EdgeInsets.only(bottom: Adapt.px(50)),
        child: Row(
          children: <Widget>[
            SizedBox(width: Adapt.px(80), child: Text(date)),
            Icon(
              Icons.radio_button_checked,
              size: Adapt.px(30),
              color: Colors.grey,
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Container(
              width: Adapt.screenW() - Adapt.px(190),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: d.title ?? d.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(text: ' as ', style: TextStyle(color: Colors.grey)),
                  TextSpan(
                      text: d.character,
                      style: TextStyle(color: Colors.black87)),
                ]),
              ),
            ),
          ],
        ));
  }
  
  Widget _buildShimmerCell() {
    return SizedBox(
        child: Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Row(
        children: <Widget>[
          Container(
            height: Adapt.px(30),
            width: Adapt.px(60),
            color: Colors.grey[200],
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Icon(
            Icons.radio_button_checked,
            size: Adapt.px(30),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Container(
            height: Adapt.px(30),
            width: Adapt.px(500),
            color: Colors.grey[200],
          ),
        ],
      ),
    ));
  }

  Widget _timeLineBody() {
    if (state.creditsModel.cast.length > 0)
      return ListView(
          physics: state.scrollPhysics,
          shrinkWrap: true,
          children: state.creditsModel.cast
              .where((d) => d.media_type == filter)
              .toList()
              .map(_buildTimelineCell)
              .toList());
    else
      return ListView(
        physics: state.scrollPhysics,
        shrinkWrap: true,
        children: <Widget>[
          _buildShimmerCell(),
          SizedBox(
            height: Adapt.px(50),
          ),
          _buildShimmerCell(),
          SizedBox(
            height: Adapt.px(50),
          ),
          _buildShimmerCell(),
          SizedBox(
            height: Adapt.px(50),
          ),
          _buildShimmerCell(),
          SizedBox(
            height: Adapt.px(50),
          ),
          _buildShimmerCell(),
          SizedBox(
            height: Adapt.px(50),
          ),
          _buildShimmerCell(),
          SizedBox(
            height: Adapt.px(50),
          ),
        ],
      );
  }

  return Container(
    child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
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
      SizedBox(
        height: Adapt.px(10),
      ),
      Padding(
        padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
        child: _timeLineBody(),
      ),
      /*Padding(
        padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
        child: Timeline(
            shrinkWrap: true,
            position: TimelinePosition.Center,
            physics: PageScrollPhysics(),
            children:
                state.creditsModel.cast.map(_buildTimelineModel).toList()),
      ),*/
    ]),
  );
}
