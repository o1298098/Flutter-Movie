import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/keepalive_widget.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/style/themestyle.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TvShowLiveStreamPageState state, Dispatch dispatch,
    ViewService viewService) {
  Widget _getPlayer() {
    double _height = Adapt.screenW() * 9 / 16;
    String key = state.streamLinkType?.name ?? '';
    switch (key) {
      case 'YouTube':
        return YoutubePlayer(
          controller: state.youtubePlayerController,
          topActions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: Adapt.px(80),
              ),
              onPressed: () => Navigator.of(viewService.context).pop(),
            )
          ],
          progressIndicatorColor: Colors.red,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      case 'WebView':
        return AspectRatio(
          key: ValueKey(state.streamAddress),
          aspectRatio: 16 / 9,
          child: InAppWebView(
              initialUrl: state.streamAddress,
              initialHeaders: {},
              initialOptions: InAppWebViewWidgetOptions(
                  inAppWebViewOptions: InAppWebViewOptions(
                debuggingEnabled: true,
              ))),
        );
      case 'other':
        return Container(
          color: Colors.black,
          alignment: Alignment.bottomCenter,
          height: _height,
          child: state.chewieController != null
              ? Chewie(
                  key: ValueKey(state.chewieController),
                  controller: state.chewieController)
              : SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
        );
      default:
        return Container(
          height: _height,
          color: Colors.black,
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Navigator.of(viewService.context).pop(),
          ),
        );
    }
  }

  return Builder(
    builder: (context) {
      final MediaQueryData _mediaQuery = MediaQuery.of(context);
      final ThemeData _theme = ThemeStyle.getTheme(context);
      Widget _buildCommentInputCell() {
        return Container(
            decoration: BoxDecoration(
                color: _theme.backgroundColor,
                border:
                    Border(top: BorderSide(color: _theme.primaryColorDark))),
            child: SafeArea(
              top: false,
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.px(30), Adapt.px(10), Adapt.px(30), 0),
                  margin: EdgeInsets.symmetric(
                      vertical: Adapt.px(20), horizontal: Adapt.px(20)),
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                      color: _theme.primaryColorLight,
                      borderRadius: BorderRadius.circular(Adapt.px(40))),
                  child: TextField(
                    onSubmitted: (s) => dispatch(
                        TvShowLiveStreamPageActionCreator.addComment(s)),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: Adapt.px(35)),
                      labelStyle: TextStyle(fontSize: Adapt.px(35)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      hintText: 'Add a comment',
                    ),
                  )),
            ));
      }

      Widget _buildVideoPlayer() {
        double _height = Adapt.screenW() * 9 / 16;
        return SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
              maxHeight: _height + Adapt.padTopH(),
              minHeight: _height + Adapt.padTopH(),
              child: Container(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      height: Adapt.padTopH(),
                    ),
                    _getPlayer()
                  ],
                ),
              )),
        );
      }

      Widget _buildHeader() {
        return Container(
          key: ValueKey('HeaderInfo'),
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: Adapt.screenW() - Adapt.px(95),
                    child: Text(
                      state.selectedEpisode?.name ?? 'no title',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () => dispatch(
                        TvShowLiveStreamPageActionCreator.headerExpanded()),
                    child: Icon(
                      state.isExpanded != CrossFadeState.showFirst
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: Adapt.px(35),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                children: <Widget>[
                  Text('${state.selectedEpisode?.airDate}'),
                  SizedBox(width: Adapt.px(20)),
                  RatingBarIndicator(
                    itemSize: Adapt.px(30),
                    itemPadding: EdgeInsets.symmetric(horizontal: Adapt.px(2)),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.grey,
                    rating: (state.selectedEpisode?.voteAverage ?? 0) / 2,
                  ),
                  SizedBox(width: Adapt.px(8)),
                  Text(
                      '${state.selectedEpisode?.voteAverage?.toStringAsFixed(1)}   (${state.selectedEpisode?.voteCount})'),
                ],
              ),
              AnimatedCrossFade(
                crossFadeState: state.isExpanded,
                duration: Duration(milliseconds: 300),
                firstCurve: Curves.ease,
                secondCurve: Curves.ease,
                sizeCurve: Curves.ease,
                firstChild: SizedBox(),
                secondChild: Padding(
                    padding: EdgeInsets.only(top: Adapt.px(10)),
                    child: Material(
                        color: Colors.transparent,
                        child: Text(
                          state.selectedEpisode?.overview ?? '',
                        ))),
              ),
            ],
          ),
        );
      }

      Widget _buildStreamLinkCell(TvShowStreamLink d) {
        return GestureDetector(
            onTap: () {
              if (d.episode != state.episodeNumber)
                dispatch(
                    TvShowLiveStreamPageActionCreator.episodeCellTapped(d));
            },
            child: Container(
              margin: EdgeInsets.only(left: Adapt.px(30)),
              padding: EdgeInsets.all(Adapt.px(20)),
              width: Adapt.px(300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                border: Border.all(
                    color: d.episode == state.episodeNumber
                        ? _mediaQuery.platformBrightness == Brightness.light
                            ? Colors.black
                            : Colors.white
                        : Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Episode ${d.episode}'),
                  SizedBox(height: Adapt.px(15)),
                  Text(
                    '${d.linkName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
                  ),
                ],
              ),
            ));
      }

      Widget _buildMoreStreamLinkCell(TvShowStreamLink d) {
        return GestureDetector(
            onTap: () {
              if (d.episode != state.episodeNumber)
                dispatch(
                    TvShowLiveStreamPageActionCreator.episodeCellTapped(d));
              Navigator.pop(viewService.context);
            },
            child: Container(
              margin: EdgeInsets.only(left: Adapt.px(30)),
              padding: EdgeInsets.all(Adapt.px(20)),
              width: Adapt.screenW() / 2 - Adapt.px(45),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(20)),
                border: Border.all(
                    color: d.episode == state.episodeNumber
                        ? _mediaQuery.platformBrightness == Brightness.light
                            ? Colors.black
                            : Colors.white
                        : Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Episode ${d.episode}'),
                  SizedBox(height: Adapt.px(15)),
                  Text(
                    '${d.linkName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
                  ),
                ],
              ),
            ));
      }

      Widget _buildShimmerLinkCell() {
        return Container(
          margin: EdgeInsets.only(left: Adapt.px(30)),
          width: Adapt.px(300),
          decoration: BoxDecoration(
            color: _theme.primaryColorLight,
            borderRadius: BorderRadius.circular(Adapt.px(20)),
          ),
        );
      }

      Widget _buildEpisodesMore() {
        return SizedBox(
          height: Adapt.px(300),
          child: Wrap(
            runSpacing: Adapt.px(30),
            children:
                state.streamLinks.list.map(_buildMoreStreamLinkCell).toList(),
          ),
        );
      }

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
            dispatch(TvShowLiveStreamPageActionCreator.episodesMoreTapped(
                _buildEpisodesMore()));
            break;
          case 'report':
            dispatch(TvShowLiveStreamPageActionCreator.streamLinkReport());
            break;
        }
      }

      Widget _buildStreamLinkList() {
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
                      style:
                          TextStyle(fontSize: Adapt.px(28), color: Colors.grey),
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
                          ?.map(_buildStreamLinkCell)
                          ?.toList() ??
                      [
                        _buildShimmerLinkCell(),
                        _buildShimmerLinkCell(),
                        _buildShimmerLinkCell()
                      ]),
            )
          ],
        );
      }

      Widget _buildTabBar() {
        return SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
              maxHeight: Adapt.px(100),
              minHeight: Adapt.px(100),
              child: Container(
                  color: _theme.backgroundColor,
                  child: TabBar(
                      isScrollable: true,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: state.tabController,
                      labelColor: _theme.tabBarTheme.labelColor,
                      indicatorColor: Color(0xFF505050),
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(
                          fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(
                          fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: 'Episoeds'),
                        Tab(
                          text: 'Comments',
                        )
                      ]))),
        );
      }

      Widget _buildEpisoedsView() {
        return MediaQuery.removePadding(
            context: viewService.context,
            removeTop: true,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildHeader(),
                _buildStreamLinkList(),
                viewService.buildComponent('castComponent')
              ],
            ));
      }

      Widget _buildTabViews() {
        return TabBarView(
          controller: state.tabController,
          children: [
            KeepAliveWidget(_buildEpisoedsView()),
            KeepAliveWidget(viewService.buildComponent('commentComponent'))
          ],
        );
      }

      return Scaffold(
        key: state.scaffold,
        backgroundColor: _theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            NestedScrollView(
              headerSliverBuilder: (_, __) {
                return <Widget>[
                  _buildVideoPlayer(),
                  _buildTabBar(),
                ];
              },
              body: _buildTabViews(),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (widget, animation) {
                    return SlideTransition(
                      position: animation
                          .drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
                      child: widget,
                    );
                  },
                  child:
                      state.showBottom ? _buildCommentInputCell() : SizedBox(),
                ))
          ],
        ),
      );
    },
  );
}
