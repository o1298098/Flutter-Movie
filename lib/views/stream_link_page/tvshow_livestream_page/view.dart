import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/keepalive_widget.dart';
import 'package:movie/widgets/sliverappbar_delegate.dart';
import 'package:movie/models/episodemodel.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TvShowLiveStreamPageState state, Dispatch dispatch,
    ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        key: state.scaffold,
        backgroundColor: _theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            NestedScrollView(
              headerSliverBuilder: (_, __) {
                return <Widget>[
                  viewService.buildComponent('player'),
                  _TabBar(
                    controller: state.tabController,
                  ),
                ];
              },
              body: TabBarView(
                controller: state.tabController,
                children: [
                  KeepAliveWidget(_EpisoedsView(
                    isExpanded: state.isExpanded,
                    selectedEpisode: state.selectedEpisode,
                    headerExpanded: () => dispatch(
                        TvShowLiveStreamPageActionCreator.headerExpanded()),
                    viewService: viewService,
                  )),
                  KeepAliveWidget(
                      viewService.buildComponent('commentComponent'))
                ],
              ),
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
                  child: state.showBottom
                      ? _CommentInputCell(
                          submit: (s) => dispatch(
                              TvShowLiveStreamPageActionCreator.addComment(s)),
                        )
                      : SizedBox(),
                )),
            viewService.buildComponent('loading'),
          ],
        ),
      );
    },
  );
}

class _Header extends StatelessWidget {
  final CrossFadeState isExpanded;
  final Episode selectedEpisode;
  final Function headerExpanded;
  const _Header({this.isExpanded, this.selectedEpisode, this.headerExpanded});
  @override
  Widget build(BuildContext context) {
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
                  selectedEpisode?.name ?? 'no title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: headerExpanded,
                child: Icon(
                  isExpanded != CrossFadeState.showFirst
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
              Text('${selectedEpisode?.airDate}'),
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
                rating: (selectedEpisode?.voteAverage ?? 0) / 2,
              ),
              SizedBox(width: Adapt.px(8)),
              Text(
                  '${selectedEpisode?.voteAverage?.toStringAsFixed(1)}   (${selectedEpisode?.voteCount})'),
            ],
          ),
          AnimatedCrossFade(
            crossFadeState: isExpanded,
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
                  selectedEpisode?.overview ?? '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final TabController controller;
  const _TabBar({this.controller});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
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
            controller: controller,
            labelColor: _theme.tabBarTheme.labelColor,
            indicatorColor: Color(0xFF505050),
            unselectedLabelColor: Colors.grey,
            labelStyle:
                TextStyle(fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Episoeds'),
              Tab(
                text: 'Comments',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentInputCell extends StatelessWidget {
  final Function(String) submit;
  const _CommentInputCell({this.submit});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      decoration: BoxDecoration(
          color: _theme.backgroundColor,
          border: Border(top: BorderSide(color: _theme.primaryColorDark))),
      child: SafeArea(
        top: false,
        child: Container(
          padding:
              EdgeInsets.fromLTRB(Adapt.px(30), Adapt.px(10), Adapt.px(30), 0),
          margin: EdgeInsets.symmetric(
              vertical: Adapt.px(20), horizontal: Adapt.px(20)),
          height: Adapt.px(80),
          decoration: BoxDecoration(
              color: _theme.primaryColorLight,
              borderRadius: BorderRadius.circular(Adapt.px(40))),
          child: TextField(
            onSubmitted: (s) => submit(s),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: Adapt.px(35)),
              labelStyle: TextStyle(fontSize: Adapt.px(35)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0)),
              hintText: 'Add a comment',
            ),
          ),
        ),
      ),
    );
  }
}

class _EpisoedsView extends StatelessWidget {
  final CrossFadeState isExpanded;
  final Episode selectedEpisode;
  final Function headerExpanded;
  final ViewService viewService;
  const _EpisoedsView(
      {this.headerExpanded,
      this.isExpanded,
      this.selectedEpisode,
      this.viewService});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Adapt.px(50)),
      shrinkWrap: true,
      children: <Widget>[
        _Header(
          isExpanded: isExpanded,
          selectedEpisode: selectedEpisode,
          headerExpanded: headerExpanded,
        ),
        viewService.buildComponent('streamLink'),
        viewService.buildComponent('castComponent')
      ],
    );
  }
}
