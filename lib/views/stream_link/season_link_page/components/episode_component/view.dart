import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/stream_link/season_link_page/action.dart';

import 'state.dart';

Widget buildView(
    EpisodeState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  return InkWell(
      key: ValueKey('Episode${state.episode.id}'),
      onTap: () => dispatch(
          SeasonLinkPageActionCreator.onEpisodeCellTapped(state.episode)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Adapt.px(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.antiAlias,
              children: <Widget>[
                Container(
                  width: Adapt.px(220),
                  height: Adapt.px(130),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(10)),
                      color: _theme.primaryColorDark,
                      image: DecorationImage(
                          colorFilter: state.episode.streamLink == null
                              ? ColorFilter.mode(Colors.grey, BlendMode.color)
                              : null,
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(ImageUrl.getUrl(
                              state.episode.stillPath, ImageSize.w300)))),
                ),
                state.episode.streamLink != null && !state.episode.playState
                    ? Positioned(
                        top: -5,
                        right: -5,
                        child: Container(
                          width: Adapt.px(25),
                          height: Adapt.px(25),
                          //transform: Matrix4.translationValues(Adapt.px(204), -Adapt.px(8), 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.orangeAccent),
                        ))
                    : const SizedBox()
              ],
            ),
            SizedBox(width: Adapt.px(20)),
            Container(
                width: Adapt.screenW() - Adapt.px(300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: '${state.episode.episodeNumber}. ',
                            style: TextStyle(fontSize: Adapt.px(28))),
                        TextSpan(
                            text: '${state.episode.name}',
                            style: TextStyle(
                                fontSize: Adapt.px(28),
                                fontWeight: FontWeight.w800)),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Adapt.px(5)),
                    Text(
                      '${state.episode.overview}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ))
          ],
        ),
      ));
}
