import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PopularState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildMoreCell() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(Adapt.px(15)),
      ),
      width: Adapt.px(400),
      height: Adapt.px(225),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          I18n.of(viewService.context).more,
          style: TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
        ),
        Icon(Icons.arrow_forward, size: Adapt.px(35))
      ]),
    );
  }

  Widget _buildCell(VideoListResult d) {
    return Padding(
      key: ValueKey(d.id),
      padding: EdgeInsets.only(left: Adapt.px(20)),
      child:GestureDetector(
        onTap: ()=>dispatch(PopularActionCreator.onCellTapped(d.id, d.backdrop_path,state.showmovie?d.title:d.name,d.poster_path)),
        child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(Adapt.px(15)),
            child: CachedNetworkImage(
              fadeOutDuration:Duration(milliseconds: 200),
              fadeInDuration: Duration(milliseconds: 200),
               width: Adapt.px(400),
              height: Adapt.px(225),
              fit: BoxFit.cover,
              imageUrl:d.backdrop_path==null?ImageUrl.emptyimage: ImageUrl.getUrl(d.backdrop_path, ImageSize.w400),
              placeholder: (ctx,s){
                return Image.asset('images/CacheBG.jpg',  
                fit: BoxFit.cover,
                width: Adapt.px(400),
              height: Adapt.px(225),);},
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            width: Adapt.px(400),
            padding: EdgeInsets.all(Adapt.px(10)),
            child: Text(d.title??d.name,
              style: TextStyle(
                color:Colors.white,
                fontSize: Adapt.px(28),
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(color: Colors.black87,offset: Offset(Adapt.px(2),Adapt.px(2))),
                ]
                ),)
          )
        ],
      ),
      ) ,
    );
  }

  Widget _buildShimmerCell() {
    return SizedBox(
      width: Adapt.px(400),
      height: Adapt.px(225),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Adapt.px(15)),
          ),
        ),
      ),
    );
  }

  Widget _buildbody() {
    VideoListModel model =
        state.showmovie ? state.popularMoives : state.popularTVShows;
    return AnimatedSwitcher(
      transitionBuilder: (widget,animated){
        return SlideTransition(
          position: animated.drive(Tween(begin:Offset(1,0),end:Offset.zero)),
          child: widget,
        );
      },
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      child:Container(
        key: ValueKey(model),
      height: Adapt.px(225),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: PageScrollPhysics(),
        shrinkWrap: true,
        children: model.results.length > 0
            ? (model.results.map(_buildCell).toList()..add(_buildMoreCell()))
            : <Widget>[
                SizedBox(
                  width: Adapt.px(20),
                ),
                _buildShimmerCell(),
                SizedBox(
                  width: Adapt.px(20),
                ),
                _buildShimmerCell(),
                SizedBox(
                  width: Adapt.px(20),
                ),
                _buildShimmerCell(),
                SizedBox(
                  width: Adapt.px(20),
                ),
                _buildShimmerCell()
              ],
      ),
    )
    ) ;
  }

  return _buildbody();
}
