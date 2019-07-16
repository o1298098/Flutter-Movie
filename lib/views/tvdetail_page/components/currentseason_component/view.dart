import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CurrentSeasonState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildShimmerCell() {
    return SizedBox(
      height: Adapt.px(360),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: Adapt.px(30),
            ),
            Container(
              width: Adapt.px(250),
              height: Adapt.px(360),
              color: Colors.grey[200],
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(200),
                  height: Adapt.px(35),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.px(300),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(340),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(8),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(400),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCell() {
    if (state.nowseason == null)
      return _buildShimmerCell();
    else {
      var airdata = state.nextToAirData ?? state.lastToAirData;
      return GestureDetector(
        onTap: () => dispatch(CurrentSeasonActionCreator.onCellTapped(
            state.tvid,
            state.nowseason.season_number,
            state.nowseason.name,
            state.nowseason.poster_path)),
        child: Container(
          padding: EdgeInsets.only(left: Adapt.px(20), right: Adapt.px(20)),
          child: Card(
            child: Row(
              children: <Widget>[
                Hero(
                  tag: 'seasonpic',
                  child: CachedNetworkImage(
                    width: Adapt.px(250),
                    height: Adapt.px(375),
                    fit: BoxFit.cover,
                    imageUrl: state.nowseason.poster_path == null
                        ? ImageUrl.emptyimage
                        : ImageUrl.getUrl(
                            state.nowseason.poster_path, ImageSize.w200),
                  ),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: 'seasonname',
                      child: Container(
                        width: Adapt.screenW() - Adapt.px(340),
                        child:Text(
                        state.nowseason.name ?? '',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Adapt.px(35),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Container(
                        width: Adapt.screenW() - Adapt.px(340),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: Adapt.px(24),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(text: airdata?.air_date ?? ''),
                                TextSpan(text: ' | '),
                                TextSpan(text: airdata?.name ?? '')
                              ]),
                        )),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(360),
                      child: Text(
                        state.nowseason.overview?.isNotEmpty == true
                            ? state.nowseason.overview
                            : '${state.nowseason.name} of ${state.name} premiered on ${DateFormat.yMMMd().format(DateTime.tryParse(state.nowseason.air_date??'1900-01-01'))}',
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(I18n.of(viewService.context).currentSeason,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Adapt.px(40),
                      fontWeight: FontWeight.w800)),
              Text('View All Seasons')
            ],
          )),
      _buildCell()
    ],
  );
}
