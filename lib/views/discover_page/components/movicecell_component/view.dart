import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/actions/votecolorhelper.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/discover_page/action.dart';

import 'state.dart';

Widget buildView(
    VideoCellState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  Widget _buildListCell() {
    final bool ismovie = state.isMovie;
    final VideoListResult d = state.videodata;
    if (d == null) return SizedBox();
    return GestureDetector(
      key: ValueKey(d.name),
      child: Container(
        padding:
            EdgeInsets.fromLTRB(Adapt.px(20), 0, Adapt.px(20), Adapt.px(30)),
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Adapt.px(260),
                height: Adapt.px(400),
                decoration: BoxDecoration(
                    color: _theme.primaryColorLight,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(d.posterPath, ImageSize.w300)))),
              ),
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
                                                  d.voteAverage)),
                                      backgroundColor: Colors.grey,
                                      value: d.voteAverage / 10.0,
                                    )),
                              ),
                              Center(
                                child: Container(
                                    width: Adapt.px(60),
                                    height: Adapt.px(60),
                                    child: Center(
                                      child: Text(
                                        (d.voteAverage * 10.0)
                                                .floor()
                                                .toString() +
                                            '%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: Adapt.px(20),
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
                                (ismovie ? d.title : d.name) ?? '',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Adapt.px(26)),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(DateTime.tryParse(
                                  (ismovie
                                      ? _changeDatetime(d.releaseDate)
                                      : _changeDatetime(d.firstAirDate)))),
                              style: TextStyle(
                                  color: _theme.textTheme.subtitle.color,
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
                        d.overview ?? '',
                        softWrap: true,
                        maxLines: 7,
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
      onTap: () => dispatch(
          DiscoverPageActionCreator.onVideoCellTapped(d.id, d.posterPath)),
    );
  }

  return _buildListCell();
}

String _changeDatetime(String s1) {
  return s1 == null || s1 == '' ? '1900-01-01' : s1;
}
