import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/expandable_text.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(top: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.name ?? '',
            style: TextStyle(
              fontSize: Adapt.px(35),
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          SizedBox(height: Adapt.px(40)),
          Row(children: [
            Container(
              width: Adapt.px(80),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                image: state.detail.posterPath != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(
                              state.detail.posterPath, ImageSize.w300),
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(width: Adapt.px(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd()
                      .format(DateTime.parse(state.detail.releaseDate)),
                ),
                Text(
                  state.detail.genres.take(2).map((e) => e.name).join(' · '),
                  style: TextStyle(
                    fontSize: Adapt.px(24),
                    color: const Color(0xFF717171),
                  ),
                ),
              ],
            ),
            Spacer(),
            viewService.buildComponent('cast')
          ]),
          SizedBox(height: Adapt.px(40)),
          ExpandableText(
            state.overview,
            maxLines: 3,
            style: TextStyle(color: const Color(0xFF717171), height: 1.5),
          )
        ],
      ),
    ),
  );
}
