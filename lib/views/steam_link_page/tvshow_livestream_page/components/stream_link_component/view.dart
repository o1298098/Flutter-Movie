import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/steam_link_page/tvshow_livestream_page/action.dart';

import 'state.dart';

Widget buildView(
    StreamLinkState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildPopupMenuButton(IconData icon, String title) {
    return PopupMenuItem(
      value: title,
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: Adapt.px(20)),
          Text(title)
        ],
      ),
    );
  }

  _popItemSelected(String title) {
    switch (title) {
      case 'more':
        dispatch(
            TvShowLiveStreamPageActionCreator.episodesMoreTapped(_EpisodesMore(
          data: state.streamLinks,
          dispatch: dispatch,
          episodeNumber: state.episodeNumber,
        )));
        break;
      case 'report':
        dispatch(TvShowLiveStreamPageActionCreator.streamLinkReport());
        break;
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: Adapt.px(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'Episodes',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: Adapt.px(30)),
              ),
              TextSpan(
                text: ' ${state.streamLinks?.list?.length ?? ''}',
                style: TextStyle(fontSize: Adapt.px(28), color: Colors.grey),
              )
            ])),
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              onSelected: _popItemSelected,
              itemBuilder: (_) {
                return <PopupMenuEntry<String>>[
                  _buildPopupMenuButton(
                    Icons.more,
                    'more',
                  ),
                  _buildPopupMenuButton(
                    Icons.bug_report,
                    'report',
                  )
                ];
              },
            ),
          ],
        ),
      ),
      SizedBox(height: Adapt.px(30)),
      SizedBox(
        height: Adapt.px(130),
        child: ListView(
            physics: ClampingScrollPhysics(),
            controller: state.episodelistController,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: state.streamLinks?.list
                    ?.map((d) => _StreamLinkCell(
                          episodeNumber: state.episodeNumber,
                          data: d,
                          onTap: (e) {
                            if (e.episode != state.episodeNumber)
                              dispatch(TvShowLiveStreamPageActionCreator
                                  .episodeCellTapped(e));
                          },
                        ))
                    ?.toList() ??
                [_ShimmerLinkCell(), _ShimmerLinkCell(), _ShimmerLinkCell()]),
      )
    ],
  );
}

class _ShimmerLinkCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      margin: EdgeInsets.only(left: Adapt.px(30)),
      width: Adapt.px(300),
      decoration: BoxDecoration(
        color: _theme.primaryColorLight,
        borderRadius: BorderRadius.circular(Adapt.px(20)),
      ),
    );
  }
}

class _StreamLinkCell extends StatelessWidget {
  final TvShowStreamLink data;
  final int episodeNumber;
  final Function(TvShowStreamLink) onTap;
  const _StreamLinkCell({this.data, this.episodeNumber, this.onTap});
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        margin: EdgeInsets.only(left: Adapt.px(30)),
        padding: EdgeInsets.all(Adapt.px(20)),
        width: Adapt.px(300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          border: Border.all(
              color: data.episode == episodeNumber
                  ? _mediaQuery.platformBrightness == Brightness.light
                      ? Colors.black
                      : Colors.white
                  : Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Episode ${data.episode}'),
            SizedBox(height: Adapt.px(15)),
            Text(
              '${data.linkName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreStreamLinkCell extends StatelessWidget {
  final TvShowStreamLink data;
  final int episodeNumber;
  final Function(TvShowStreamLink) onTap;
  const _MoreStreamLinkCell({this.data, this.episodeNumber, this.onTap});
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        margin: EdgeInsets.only(left: Adapt.px(30)),
        padding: EdgeInsets.all(Adapt.px(20)),
        width: Adapt.screenW() / 2 - Adapt.px(45),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          border: Border.all(
              color: data.episode == episodeNumber
                  ? _mediaQuery.platformBrightness == Brightness.light
                      ? Colors.black
                      : Colors.white
                  : Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Episode ${data.episode}'),
            SizedBox(height: Adapt.px(15)),
            Text(
              '${data.linkName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
            ),
          ],
        ),
      ),
    );
  }
}

class _EpisodesMore extends StatelessWidget {
  final TvShowStreamLinks data;
  final int episodeNumber;
  final Dispatch dispatch;
  const _EpisodesMore({this.data, this.dispatch, this.episodeNumber});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Adapt.px(300),
      child: Wrap(
        runSpacing: Adapt.px(30),
        children: data.list
            .map((d) => _MoreStreamLinkCell(
                  data: d,
                  episodeNumber: episodeNumber,
                  onTap: (e) {
                    if (e.episode != episodeNumber)
                      dispatch(
                          TvShowLiveStreamPageActionCreator.episodeCellTapped(
                              e));
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ),
    );
  }
}
