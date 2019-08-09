import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/models/seasondetail.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodesState state, Dispatch dispatch, ViewService viewService) {
  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildEpisodeCell(Episode d) {
    return Container(
      key: ValueKey(d.id),
      padding: EdgeInsets.only(bottom: Adapt.px(30)),
      child: GestureDetector(
        onTap: () => dispatch(EpisodesActionCreator.onCellTapped(d)),
        child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                side: BorderSide(
              color: Colors.grey[300],
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: 'pic' + d.episode_number.toString(),
                  child: Container(
                    width: Adapt.screenW() - Adapt.px(40),
                    height: (Adapt.screenW() - Adapt.px(40)) * 9 / 16,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(
                            random.nextInt(255),
                            random.nextInt(255),
                            random.nextInt(255),
                            random.nextDouble()),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                d.still_path == null
                                    ? ImageUrl.emptyimage
                                    : ImageUrl.getUrl(
                                        d.still_path, ImageSize.w300)))),
                  ),
                ),
                Hero(
                  tag: 'episodeDate' + d.episode_number.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        height: Adapt.px(50),
                        padding: EdgeInsets.fromLTRB(Adapt.px(20), Adapt.px(10),
                            Adapt.px(20), Adapt.px(10)),
                        child: Text(
                          DateFormat.yMMMd().format(
                              DateTime.parse(d.air_date ?? '1990-01-01')),
                          style: TextStyle(fontSize: Adapt.px(24)),
                        )),
                  ),
                ),
                Hero(
                  tag: 'episodetitle' + d.episode_number.toString(),
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
                                d.vote_average.toStringAsFixed(1),
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
                            '${d.episode_number}  ${d.name}',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Hero(
                  tag: 'episodeoverWatch' + d.episode_number.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(Adapt.px(20), Adapt.px(10),
                          Adapt.px(20), Adapt.px(20)),
                      child: Text(d.overview ?? '-'),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildShimmerCell() {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[100],
          child: Column(
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
                margin:
                    EdgeInsets.only(left: Adapt.px(20), bottom: Adapt.px(8)),
                color: Colors.grey[200],
                width: Adapt.screenW() - Adapt.px(100),
                height: Adapt.px(24),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: Adapt.px(20), bottom: Adapt.px(8)),
                color: Colors.grey[200],
                width: Adapt.screenW() - Adapt.px(100),
                height: Adapt.px(24),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: Adapt.px(20), bottom: Adapt.px(8)),
                color: Colors.grey[200],
                width: Adapt.screenW() - Adapt.px(300),
                height: Adapt.px(24),
              )
            ],
          )),
    );
  }

  return Column(
      key: ValueKey(state.episodes),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: I18n.of(viewService.context).episodes,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Adapt.px(35),
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ' ${state.episodes != null ? state.episodes.length.toString() : ''}',
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
          ])),
        ),
        Padding(
          padding: EdgeInsets.only(left: Adapt.px(20), right: Adapt.px(20)),
          child: Column(
            children: state.episodes.length > 0
                ? state.episodes.map(_buildEpisodeCell).toList()
                : [
                    _buildShimmerCell(),
                    SizedBox(
                      height: Adapt.px(30),
                    ),
                    _buildShimmerCell(),
                    SizedBox(
                      height: Adapt.px(30),
                    ),
                    _buildShimmerCell(),
                  ],
          ),
        )
      ]);
}
