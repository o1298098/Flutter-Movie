import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    VideoCellState state, Dispatch dispatch, ViewService viewService) {
  var d = state.videodata;
  return GestureDetector(
    key: Key(d.original_title),
    child: Container(
      padding: EdgeInsets.fromLTRB(Adapt.px(20), 0, Adapt.px(20), Adapt.px(30)),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: Adapt.px(260),
                height: Adapt.px(400),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'images/CacheBG.jpg',
                  image: ImageUrl.getUrl(
                      d.poster_path ?? '/lrzvimkeL72qxHN1FaSmjIoztvj.jpg',
                      ImageSize.w300),
                )),
            Container(
              padding: EdgeInsets.all(Adapt.px(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: Adapt.px(80),
                        height: Adapt.px(80),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: Adapt.px(80),
                                height: Adapt.px(80),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                        BorderRadius.circular(Adapt.px(40))),
                              ),
                            ),
                            Center(
                              child: Container(
                                  width: Adapt.px(60),
                                  height: Adapt.px(60),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            VoteColorHelper.getColor(
                                                d.vote_average)),
                                    backgroundColor: Colors.grey,
                                    value: d.vote_average / 10.0,
                                  )),
                            ),
                            Center(
                              child: Container(
                                  width: Adapt.px(60),
                                  height: Adapt.px(60),
                                  child: Center(
                                    child: Text(
                                      (d.vote_average * 10.0)
                                              .floor()
                                              .toString() +
                                          '%',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Adapt.px(22),
                                          color: Colors.white),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Adapt.px(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Adapt.screenW() - Adapt.px(450),
                            child: Text(
                              d.title,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Adapt.px(26)),
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(DateTime.parse((d.release_date==null||d.release_date?.isEmpty==true)?'1970-01-01':d.release_date)),
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: Adapt.px(20)),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Container(
                    width: Adapt.screenW() - Adapt.px(360),
                    child: Text(
                      d.overview,
                      softWrap: true,
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
    onTap: () => dispatch(MovieCellActionCreator.onMovieCellTapped(d.id)),
  );
}
