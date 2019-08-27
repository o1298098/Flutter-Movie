import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/imagemodel.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GalleryPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildImageCell(ImageData d, int index) {
    double width = Adapt.screenW() / 2;
    return Hero(
      key: ValueKey('image${d.file_path}'),
      tag: 'image${d.file_path}',
      child: Container(
        width: width,
        height: width / d.aspect_ratio,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Adapt.px(20)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(d.file_path, ImageSize.w300)))),
      ),
    );
  }

  return Scaffold(
    appBar: AppBar(
      elevation: 10.0,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    body: StaggeredGridView.countBuilder(
      primary: false,
      crossAxisCount: 4,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      itemCount: state.images.length,
      itemBuilder: (context, index) =>
          _buildImageCell(state.images[index], index),
      staggeredTileBuilder: (index) =>
          new StaggeredTile.count(2, index.isEven ? 4 : 3),
    ),
  );
}
