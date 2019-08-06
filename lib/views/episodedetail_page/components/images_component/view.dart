import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ImagesState state, Dispatch dispatch, ViewService viewService) {
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildImageCell(ImageData d) {
    String url = d.file_path == null
        ? ImageUrl.emptyimage
        : ImageUrl.getUrl(d.file_path, ImageSize.w500);
    int index = state.images.stills.indexOf(d);
    return GestureDetector(
      onTap: //() => dispatch(ImagesActionCreator.onImageTapped(url)),
          () {
        dispatch(ImagesActionCreator.onGalleryImageTapped(index));
      },
      child: Hero(
        tag: url + index.toString(),
        child: Container(
          margin: EdgeInsets.only(right: Adapt.px(20)),
          height: Adapt.px(200),
          width: Adapt.px(350),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(15)),
              color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
                  random.nextInt(255), random.nextDouble()),
              image: DecorationImage(
                  fit: BoxFit.cover, image: CachedNetworkImageProvider(url))),
        ),
      ),
    );
  }

  Widget _buildImageShimmerCell() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Container(
          margin: EdgeInsets.only(right: Adapt.px(20)),
          height: Adapt.px(200),
          width: Adapt.px(350),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(15)),
            color: Colors.grey[200],
          )),
    );
  }

  Widget _getImagesBody() {
    if (state.images != null) {
      if (state.images.stills.length > 0) {
        return Container(
          height: Adapt.px(200),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: state.images.stills.map(_buildImageCell).toList()
              ..insert(
                  0,
                  SizedBox(
                    width: Adapt.px(28),
                  )),
          ),
        );
      } else
        return Container(
          width: Adapt.screenW(),
          padding: EdgeInsets.only(left: Adapt.px(28)),
          child: Text(I18n.of(viewService.context).episodeImages),
        );
    } else
      return Container(
          height: Adapt.px(200),
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            SizedBox(
              width: Adapt.px(28),
            ),
            _buildImageShimmerCell(),
            _buildImageShimmerCell(),
            _buildImageShimmerCell(),
          ]));
  }

  return AnimatedSwitcher(
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
    duration: Duration(milliseconds: 600),
    child: Column(
        key: ValueKey(state.images),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(Adapt.px(28), 0, Adapt.px(28), 0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: I18n.of(viewService.context).episodeImages,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Adapt.px(35),
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      ' ${state.images != null ? state.images.stills.length.toString() : ''}',
                  style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
            ])),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          _getImagesBody(),
          SizedBox(
            height: Adapt.px(30),
          ),
        ],
      ),
  );
}
