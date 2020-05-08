import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LiveStreamPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              viewService.buildComponent('player'),
              _HeaderInfo(
                name: state.name,
                releaseDate: state.releaseDate,
                rated: state.rated,
                rateCount: state.rateCount,
              ),
              viewService.buildComponent('streamLinks'),
              _CommentsTitle(
                commentController: state.commentController,
                commentFocusNode: state.commentFocusNode,
                user: state.user.firebaseUser,
                submit: () => dispatch(LiveStreamPageActionCreator.addComment(
                    state.commentController.text)),
              ),
              viewService.buildComponent('comments'),
            ],
          ),
          viewService.buildComponent('loading'),
        ],
      ),
    );
  });
}

class _HeaderInfo extends StatelessWidget {
  final String name;
  final String releaseDate;
  final double rated;
  final int rateCount;
  const _HeaderInfo({this.name, this.rateCount, this.rated, this.releaseDate});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        key: ValueKey('HeaderInfo'),
        child: Container(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  name ?? 'no title',
                  style: TextStyle(
                      fontSize: Adapt.px(50), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                children: <Widget>[
                  Text(releaseDate ?? ''),
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
                    rating: (rated ?? 0) / 2,
                  ),
                  SizedBox(width: Adapt.px(8)),
                  Text('$rated  ($rateCount)')
                ],
              ),
              SizedBox(height: Adapt.px(30)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _Button(
                  icon: Icons.thumb_up,
                  title: '0',
                ),
                _Button(
                  icon: Icons.thumb_down,
                  title: 'unlike',
                ),
                _Button(
                  icon: Icons.cloud_download,
                  title: 'download',
                  onPressed: () async =>
                      await Navigator.of(context).pushNamed('downloadPage'),
                ),
                _Button(
                  icon: Icons.comment,
                  title: 'commnet',
                ),
              ])
            ],
          ),
        ));
  }
}

class _Button extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData icon;
  const _Button({this.icon, this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            size: Adapt.px(40),
            color: Colors.grey,
          ),
          SizedBox(height: Adapt.px(8)),
          Text(title)
        ],
      ),
    );
  }
}

class _CommentsTitle extends StatelessWidget {
  final FirebaseUser user;
  final TextEditingController commentController;
  final FocusNode commentFocusNode;
  final Function submit;
  const _CommentsTitle(
      {this.user, this.commentController, this.commentFocusNode, this.submit});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
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
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(user?.photoUrl ?? ''),
                  ),
                ),
              ),
              SizedBox(width: Adapt.px(30)),
              Container(
                width: Adapt.screenW() - Adapt.px(180),
                height: Adapt.px(100),
                child: TextField(
                  controller: commentController,
                  focusNode: commentFocusNode,
                  cursorColor: Colors.grey,
                  onSubmitted: (s) => submit(),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: Adapt.px(35)),
                    labelStyle: TextStyle(fontSize: Adapt.px(35)),
                    suffix: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => submit(),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
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
}
