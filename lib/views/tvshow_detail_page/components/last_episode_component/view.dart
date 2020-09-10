import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/tvshow_detail_page/action.dart';

import 'state.dart';

Widget buildView(
    LastEpisodeState state, Dispatch dispatch, ViewService viewService) {
  return state.lastEpisodeToAir == null
      ? SizedBox()
      : _LastEpisodePanel(
          data: state.lastEpisodeToAir,
          moreTapped: () => dispatch(TvShowDetailActionCreator.moreEpisode()),
        );
}

class _LastEpisodePanel extends StatelessWidget {
  final AirData data;
  final Function moreTapped;
  const _LastEpisodePanel({this.data, this.moreTapped});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              I18n.of(context).lastEpisode,
              style: TextStyle(
                fontSize: Adapt.px(28),
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: moreTapped,
              child: Text(
                'more',
                style: TextStyle(
                    fontSize: Adapt.px(24), color: const Color(0xFF2196F3)),
              ),
            )
          ]),
          SizedBox(height: Adapt.px(30)),
          GestureDetector(
              onTap: moreTapped,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _theme.primaryColorLight, width: Adapt.px(3)),
                  borderRadius: BorderRadius.circular(Adapt.px(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Adapt.px(200),
                      height: Adapt.px(160),
                      decoration: BoxDecoration(
                        color: _theme.primaryColorDark,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(Adapt.px(20))),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(data.stillPath, ImageSize.w300),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Adapt.px(30)),
                    SizedBox(
                      width: Adapt.screenW() - Adapt.px(346),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Adapt.px(24)),
                          ),
                          SizedBox(height: Adapt.px(5)),
                          Text(
                            'S${data.seasonNumber} · E${data.episodeNumber}',
                            style: TextStyle(fontSize: Adapt.px(18)),
                          ),
                          SizedBox(height: Adapt.px(5)),
                          Text(
                            data?.overview ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Adapt.px(18),
                              color: const Color(0xFF717171),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Adapt.px(30)),
                  ],
                ),
              )),
          SizedBox(height: Adapt.px(30)),
        ],
      ),
    );
  }
}
