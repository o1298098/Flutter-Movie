import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(CastState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildGuestStars(CastData d) {
    return GestureDetector(
        onTap: () => dispatch(CastActionCreator.onCellTapped(
            d.id, d.profile_path, d.name, d.character)),
        child: SizedBox(
            width: Adapt.px(320),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(80),
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(ImageUrl.getUrl(
                              d.profile_path, ImageSize.w300)))),
                ),
                SizedBox(width: Adapt.px(20)),
                SizedBox(
                    width: Adapt.px(220),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.name,
                          maxLines: 2,
                          style: TextStyle(fontSize: Adapt.px(24)),
                        ),
                        Text(
                          d.character,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.grey, fontSize: Adapt.px(24)),
                        )
                      ],
                    ))
              ],
            )));
  }

  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: Adapt.px(30), vertical: Adapt.px(50)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Cast',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Adapt.px(30)),
            ),
            Text(
              'more',
              style: TextStyle(fontSize: Adapt.px(30), color: Colors.grey),
            )
          ],
        ),
        SizedBox(height: Adapt.px(30)),
        Wrap(
          runSpacing: Adapt.px(30),
          spacing: Adapt.px(30),
          children:
              state.credits?.cast?.take(8)?.map(_buildGuestStars)?.toList() ??
                  [],
        ),
        SizedBox(height: Adapt.px(50)),
        Text(
          'Guest Stars',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: Adapt.px(30)),
        ),
        SizedBox(height: Adapt.px(30)),
        Wrap(
          runSpacing: Adapt.px(30),
          spacing: Adapt.px(30),
          children: state.guestStars?.map(_buildGuestStars)?.toList() ?? [],
        ),
      ],
    ),
  );
}
