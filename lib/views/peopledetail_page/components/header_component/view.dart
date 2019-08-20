import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
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
        child: Material(
          color: Colors.transparent,
          child: Text(
            state.profileName ?? '',
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(35),
                fontWeight: FontWeight.bold),
          ),
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
        state.biography == null || state.biography?.isEmpty == true
            ? "We don't have a biography for ${state.profileName}"
            : state.biography,
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
              tag: 'people${state.peopleid}${state.character ?? ''}',
              child: Container(
                width: Adapt.px(400),
                height: Adapt.px(400),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 10,
                          offset: Offset(0, 5),
                          color: Colors.black38),
                    ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(Adapt.px(30)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(state.profilePath ==
                              null
                          ? ImageUrl.emptyimage
                          : ImageUrl.getUrl(state.profilePath, ImageSize.w300)),
                    )),
              )),
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
              I18n.of(viewService.context).biography,
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
