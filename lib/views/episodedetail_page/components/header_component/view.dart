import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'state.dart';

Widget buildView(
    EpisodeHeaderState state, Dispatch dispatch, ViewService viewService) {
  final Random random = Random(DateTime.now().millisecondsSinceEpoch);
  final d = state.episode;
  return Container(
    padding: EdgeInsets.fromLTRB(Adapt.px(28), 0, Adapt.px(28), 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: 'pic' + d.episodeNumber.toString(),
          child: Container(
            width: Adapt.screenW() - Adapt.px(40),
            height: (Adapt.screenW() - Adapt.px(40)) * 9 / 16,
            decoration: BoxDecoration(
                color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
                    random.nextInt(255), random.nextDouble()),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(d.stillPath == null
                        ? ImageUrl.emptyimage
                        : ImageUrl.getUrl(d.stillPath, ImageSize.w300)))),
          ),
        ),
        Hero(
          tag: 'episodeDate' + d.episodeNumber.toString(),
          child: Material(
            color: Colors.transparent,
            child: Container(
                alignment: Alignment.centerLeft,
                height: Adapt.px(50),
                padding: EdgeInsets.fromLTRB(
                    Adapt.px(20), Adapt.px(10), Adapt.px(20), Adapt.px(10)),
                child: Text(
                  DateFormat.yMMMd().format(DateTime.parse(d.airDate)),
                  style: TextStyle(fontSize: Adapt.px(24)),
                )),
          ),
        ),
        Hero(
          tag: 'episodetitle' + d.episodeNumber.toString(),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: Adapt.px(20),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.px(10), Adapt.px(5), Adapt.px(15), Adapt.px(5)),
                  height: Adapt.px(45),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(Adapt.px(25))),
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
                        d.voteAverage.toStringAsFixed(1),
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
                    '${d.episodeNumber}  ${d.name}',
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Hero(
          tag: 'episodeoverWatch' + d.episodeNumber.toString(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  Adapt.px(20), Adapt.px(10), Adapt.px(20), Adapt.px(20)),
              child: Text(d.overview ?? '-'),
            ),
          ),
        ),
      ],
    ),
  );
}
