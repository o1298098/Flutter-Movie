import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/stream_link_page/tvshow_livestream_page/action.dart';

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
      _StreamLinkList(
        controller: state.episodelistController,
        streamLinkId: state.streamLinkId,
        dispatch: dispatch,
        streamLinks: state.streamLinks,
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

class _ShimmerLinkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: ClampingScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => _ShimmerLinkCell());
  }
}

class _StreamLinkCell extends StatelessWidget {
  final TvShowStreamLink data;
  final int streamLinkId;
  final Function(TvShowStreamLink) onTap;
  const _StreamLinkCell({this.data, this.streamLinkId, this.onTap});
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        padding: EdgeInsets.all(Adapt.px(20)),
        width: Adapt.px(300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          border: Border.all(
              color: data.sid == streamLinkId
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

class _StreamLinkList extends StatelessWidget {
  final TvShowStreamLinks streamLinks;
  final ScrollController controller;
  final int streamLinkId;
  final Dispatch dispatch;
  const _StreamLinkList(
      {this.controller, this.dispatch, this.streamLinkId, this.streamLinks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Adapt.px(130),
      child: streamLinks != null
          ? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              physics: ClampingScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: streamLinks.list.length,
              separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
              itemBuilder: (context, index) {
                final d = streamLinks.list[index];
                return _StreamLinkCell(
                  streamLinkId: streamLinkId,
                  data: d,
                  onTap: (e) {
                    if (e.sid != streamLinkId)
                      dispatch(
                          TvShowLiveStreamPageActionCreator.episodeCellTapped(
                              e));
                  },
                );
              },
            )
          : _ShimmerLinkList(),
    );
  }
}

class _MoreStreamLinkCell extends StatelessWidget {
  final TvShowStreamLink data;
  final int streamLinkId;
  final Function(TvShowStreamLink) onTap;
  const _MoreStreamLinkCell({this.data, this.streamLinkId, this.onTap});
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
              color: data.sid == streamLinkId
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
  final int streamLinkId;
  final Dispatch dispatch;
  const _EpisodesMore({this.data, this.dispatch, this.streamLinkId});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Adapt.px(300),
      child: Wrap(
        runSpacing: Adapt.px(30),
        children: data.list
            .map((d) => _MoreStreamLinkCell(
                  data: d,
                  streamLinkId: streamLinkId,
                  onTap: (e) {
                    if (e.sid != streamLinkId)
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
