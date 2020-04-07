import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LiveStreamPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildHeaderInfo() {
    return SliverToBoxAdapter(
        key: ValueKey('HeaderInfo'),
        child: Container(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  state.name ?? 'no title',
                  style: TextStyle(
                      fontSize: Adapt.px(50), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                children: <Widget>[
                  Text(state.releaseDate ?? ''),
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
                    rating: (state.rated ?? 0) / 2,
                  ),
                  SizedBox(width: Adapt.px(8)),
                  Text('${state.rated}   (${state.rateCount})')
                ],
              )
            ],
          ),
        ));
  }

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    Widget _buildCommentsTitle() {
      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Adapt.px(30), Adapt.px(30), Adapt.px(30), Adapt.px(20)),
              child: Text(
                'Comments',
                style: TextStyle(
                    fontSize: Adapt.px(40), fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: Adapt.px(30)),
                Container(
                  width: Adapt.px(80),
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _theme.primaryColorDark,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              state?.user?.photoUrl ?? ''))),
                ),
                SizedBox(width: Adapt.px(30)),
                Container(
                  width: Adapt.screenW() - Adapt.px(180),
                  height: Adapt.px(100),
                  child: TextField(
                    controller: state.commentController,
                    focusNode: state.commentFocusNode,
                    cursorColor: Colors.grey,
                    onSubmitted: (s) {
                      dispatch(LiveStreamPageActionCreator.addComment(s));
                    },
                    onChanged: (s) =>
                        dispatch(LiveStreamPageActionCreator.commentChanged(s)),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: Adapt.px(35)),
                      labelStyle: TextStyle(fontSize: Adapt.px(35)),
                      suffix: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => dispatch(
                            LiveStreamPageActionCreator.addComment(
                                state.comment)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      hintText: 'Add a comment',
                    ),
                  ),
                ),
              ],
            ),
            Divider()
          ],
        ),
      );
    }

    Widget _buildBody() {
      return Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              viewService.buildComponent('player'),
              _buildHeaderInfo(),
              viewService.buildComponent('streamLinks'),
              _buildCommentsTitle(),
              viewService.buildComponent('comments'),
            ],
          ),
          viewService.buildComponent('loading'),
        ],
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  });
}
