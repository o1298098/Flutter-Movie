import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MovieCellsState state, Dispatch dispatch, ViewService viewService) {
  Widget _bulidcell(VideoListResult d) {
    return GestureDetector(
      onTap: ()=>dispatch(MovieCellsActionCreator.onCellTapped(d.id,d.backdrop_path)),
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
                d.title,
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
  
  Widget _buildShimmerCell(){
    return SizedBox(
      width: Adapt.screenW(),
      height: Adapt.screenW() * 9 / 16,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.white,
        child: Container(
          color: Colors.grey[300],),
        ),
    );
  }

  Widget _buildMian(){
    if(state.movie.results.length>0)
    return Column(
      children: state.movie.results.take(3).map(_bulidcell).toList(),
    );
    else 
    return Column(
      children: <Widget>[
         _buildShimmerCell(),
         _buildShimmerCell(),
         _buildShimmerCell()
      ],
    );
  }
  return _buildMian();
}
