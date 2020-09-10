import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVCellState state, Dispatch dispatch, ViewService viewService) {
  final d = state.tvResult;
  return _ItemCell(
    data: d,
    onTap: () => dispatch(TVCellActionCreator.cellTapped(d)),
  );
}

class _ItemCell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _ItemCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _rightPanelWidth = Adapt.screenW() - Adapt.px(250);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Adapt.px(15)),
        constraints: BoxConstraints(minHeight: Adapt.px(280)),
        child: Row(
          children: [
            Container(
              height: Adapt.px(220),
              width: Adapt.px(160),
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(25)),
                boxShadow: [
                  BoxShadow(
                      color: _theme.brightness == Brightness.light
                          ? const Color(0xFF8E8E8E)
                          : const Color(0x00000000),
                      offset: Offset(0, Adapt.px(25)),
                      blurRadius: Adapt.px(20),
                      spreadRadius: -Adapt.px(10))
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(data.posterPath, ImageSize.w300),
                  ),
                ),
              ),
            ),
            SizedBox(width: Adapt.px(30)),
            SizedBox(
              width: _rightPanelWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(30)),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  data.genreIds.length > 0
                      ? Text(
                          data.genreIds
                              .take(3)
                              .map((e) => Genres.instance.tvList[e])
                              .join(', '),
                          style: TextStyle(
                            color: const Color(0xFF9E9E9E),
                            fontSize: Adapt.px(20),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: Adapt.px(5)),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'Next Air Date ',
                          style: TextStyle(color: const Color(0xFF9E9E9E))),
                      TextSpan(
                          text: data.nextAirDate != null
                              ? DateFormat.yMMMd()
                                  .format(DateTime.parse(data.nextAirDate))
                              : '-')
                    ]),
                    style: TextStyle(fontSize: Adapt.px(20)),
                  ),
                  SizedBox(height: Adapt.px(5)),
                  Text(
                    'S${data.season ?? '-'} · EP${data.nextEpisodeNumber ?? '-'}',
                    style: TextStyle(
                        fontSize: Adapt.px(20), color: const Color(0xFF9E9E9E)),
                  ),

                  SizedBox(height: Adapt.px(15)),
                  //Text(data.voteAverage.toString()),
                  Text(
                    data.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
