import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVCellState state, Dispatch dispatch, ViewService viewService) {
//Random random = new Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildTvCell(VideoListResult d) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Adapt.px(20)),
          child: Row(
            children: <Widget>[
              Container(
                width: Adapt.px(120),
                height: Adapt.px(180),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(d.poster_path, ImageSize.w300)))),
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Adapt.screenW() - Adapt.px(180),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: d?.name ?? '-',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Adapt.px(30),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' (${d.nextEpisodeNumber ?? '-'})',
                            style: TextStyle(
                                color: Colors.grey, fontSize: Adapt.px(30)))
                      ]),
                    ),
                  ),
                  Text('Season:' + (d.season ?? '-')),
                  Text(
                      "Air Date: " +
                          (d.nextAirDate == null ? '-' : d.nextAirDate),
                      style: TextStyle(
                          color: Colors.grey[700], fontSize: Adapt.px(24))),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Container(
                    width: Adapt.screenW() - Adapt.px(200),
                    child: Text(
                      d.overview ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  return _buildTvCell(state.tvResult);
}
