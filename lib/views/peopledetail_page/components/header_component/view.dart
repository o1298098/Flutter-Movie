import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildnamecell() {
    if (state.profileName == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          height: Adapt.px(50),
          width: Adapt.px(300),
          color: Colors.grey[200],
        ),
      ));
    else
      return Hero(
        tag: 'Actor' + state.peopleid.toString(),
        child: Text(
          state.profileName ?? '',
          style: TextStyle(
              color: Colors.black,
              fontSize: Adapt.px(35),
              fontWeight: FontWeight.bold),
        ),
      );
  }

  Widget _buildBiography() {
    if (state.biography == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: Adapt.px(60)),
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
            ],
          ),
        ),
      ));
    else
      return Text(
        state.biography==null||state.biography?.isEmpty==true ? '-':state.biography,
        style: TextStyle(fontSize: Adapt.px(30)),
      );
  }

  return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      width: Adapt.screenW(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'people' + state.peopleid.toString(),
            child: FadeInImage.assetNetwork(
              width: Adapt.px(300),
              fit: BoxFit.cover,
              placeholder: 'images/CacheBG.jpg',
              image: ImageUrl.getUrl(
                  state.profilePath ?? '/eIkFHNlfretLS1spAcIoihKUS62.jpg',
                  ImageSize.w300),
            ),
          ),
          SizedBox(
            height: Adapt.px(20),
          ),
          _buildnamecell(),
          SizedBox(
            height: Adapt.px(20),
          ),
          Container(
            alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          child: Text(
            'Biography',
            softWrap: true,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(40)),
          ),
        ),
          _buildBiography(),
        ],
      ));
}
