import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/keepalive_widget.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieListState state, Dispatch dispatch, ViewService viewService) {
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);
  Widget _buildGenreChip(int id) {
    return Container(
      margin: EdgeInsets.only(right: Adapt.px(10)),
      padding: EdgeInsets.all(Adapt.px(8)),
      child: Text(
        Genres.genres[id],
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(24)),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(Adapt.px(20))),
    );
  }

  Widget _buildShimmerCell() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          padding: EdgeInsets.all(Adapt.px(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: Adapt.px(120),
                  height: Adapt.px(180),
                  color: Colors.grey[200]),
              SizedBox(
                width: Adapt.px(20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Adapt.px(350),
                    height: Adapt.px(30),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: Adapt.px(150),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Container(
                    width: Adapt.screenW() - Adapt.px(300),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Container(
                    width: Adapt.screenW() - Adapt.px(300),
                    height: Adapt.px(24),
                    color: Colors.grey[200],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCell(VideoListResult d) {
    return Column(
      key: ValueKey<int>(d.id),
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Adapt.px(20)),
          child: Row(
            children: <Widget>[
              Container(
                width: Adapt.px(120),
                height: Adapt.px(180),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextDouble()),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(d.poster_path == null
                            ? ImageUrl.emptyimage
                            : ImageUrl.getUrl(d.poster_path, ImageSize.w300)))),
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Adapt.px(500),
                    child: Text(
                      d?.title ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Adapt.px(30),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("Release on: " + d?.release_date ?? '-',
                      style: TextStyle(
                          color: Colors.grey[700], fontSize: Adapt.px(24))),
                  SizedBox(
                    height: Adapt.px(8),
                  ),
                  Row(
                    children: d.genre_ids.take(3).map(_buildGenreChip).toList(),
                  ),
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

  return keepAliveWrapper(AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      child: ListView(
        key: ValueKey(state.moviecoming),
        controller: state.movieController,
        children: state.moviecoming.results.map(_buildMovieCell).toList()
          ..add(Offstage(
            offstage: state.moviecoming.page == state.moviecoming.total_pages &&
                state.moviecoming.results.length > 0,
            child: Column(
              children: <Widget>[
                _buildShimmerCell(),
                _buildShimmerCell(),
                _buildShimmerCell(),
                _buildShimmerCell(),
              ],
            ),
          )),
      )));
}
