import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'state.dart';

Widget buildView(
    BackGroundState state, Dispatch dispatch, ViewService viewService) {
  return state.photoUrl != null
      ? AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: CachedNetworkImage(
            key: ValueKey(state.photoUrl),
            imageUrl: ImageUrl.getUrl(state.photoUrl, ImageSize.w500),
            imageBuilder: (ctx, image) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
              image: image,
            ))),
            errorWidget: (ctx, str, object) => Container(),
          ),
        )
      : Container();
}
