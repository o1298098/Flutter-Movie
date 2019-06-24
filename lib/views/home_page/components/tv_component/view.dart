import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVCellsState state, Dispatch dispatch, ViewService viewService) {
  Widget _bulidcell(VideoListResult d) {
    return GestureDetector(
      onTap: () => dispatch(TVCellsActionCreator.onCellTapped(d.id)),
      child: Container(
        child: Stack(
          children: <Widget>[
            FadeInImage.assetNetwork(
              width: Adapt.screenW(),
              height: Adapt.screenW() * 9 / 16,
              fit: BoxFit.cover,
              placeholder: 'images/CacheBG.jpg',
              image: ImageUrl.getUrl(
                  d.backdrop_path ?? '/p60VSQL7usdxztIGokJPpHmKWdU.jpg',
                  ImageSize.w500),
            ),
            Container(
              padding: EdgeInsets.all(Adapt.px(20)),
              width: Adapt.screenW(),
              height: Adapt.screenW() * 9 / 16,
              alignment: Alignment.bottomLeft,
              child: Text(
                d.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Adapt.px(40),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  return Container(
    child: Column(
      children: state.tv.results.take(3).map(_bulidcell).toList(),
    ),
  );
}
