import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodeDetailPageState state, Dispatch dispatch, ViewService viewService) {

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    body: Container(
        padding: EdgeInsets.fromLTRB(Adapt.px(28),0,Adapt.px(28),0),
        child: Hero(
            tag: 'episode' + state.episode.episode_number.toString(),
            child: Material(
              color: Colors.transparent,
                child: Column(
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.screenW() - Adapt.px(40),
                  height: (Adapt.screenW() - Adapt.px(40)) * 9 / 16,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              state.episode.still_path == null
                                  ? ImageUrl.emptyimage
                                  : ImageUrl.getUrl(state.episode.still_path,
                                      ImageSize.w300)))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.px(20), Adapt.px(10), Adapt.px(20), Adapt.px(10)),
                  child: new Material(
                      color: Colors.transparent,
                      child: Text(
                        DateFormat.yMMMd()
                            .format(DateTime.parse(state.episode.air_date)),
                        style: TextStyle(fontSize: Adapt.px(24)),
                      )),
                ),
                Row(
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
                            state.episode.vote_average.toStringAsFixed(1),
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
                        '${state.episode.episode_number}  ${state.episode.name}',
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.px(30)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.px(20), Adapt.px(10), Adapt.px(20), Adapt.px(20)),
                  child: Text(state.episode.overview ?? '-'),
                ),
              ],
            )))),
  );
}
