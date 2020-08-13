import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/tvshow_comment.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CommentState state, Dispatch dispatch, ViewService viewService) {
  final _height = Adapt.screenH() * 0.7;
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: const Color(0x00000000),
        body: Container(
          height: Adapt.screenH(),
          decoration: BoxDecoration(
            color: _theme.backgroundColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(Adapt.px(30))),
          ),
          child: Stack(children: [
            _CommentPanel(
              height: _height,
              comments: state.comments,
              scrollController: state.scrollController,
            ),
            _CommentInputCell(
              pageHeight: Adapt.screenH() * 0.3,
              submit: (s) {
                dispatch(CommentActionCreator.addComment(s));
              },
              scrollController: state.scrollController,
            ),
          ]),
        ),
      );
    },
  );
}

class _CommentCell extends StatelessWidget {
  final TvShowComment comment;
  const _CommentCell({this.comment});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    var date = DateTime.parse(comment.updateTime ?? '1970-07-10');
    final String _timeline = TimelineUtil.format(
      date.millisecondsSinceEpoch,
      locTimeMs: DateTime.now().millisecondsSinceEpoch,
      locale: ui.window.locale.languageCode,
    );
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _theme.primaryColorDark,
              image: comment.u.photoUrl != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(comment.u.photoUrl),
                    )
                  : null,
            ),
          ),
          SizedBox(width: Adapt.px(30)),
          SizedBox(
            width: Adapt.screenW() - Adapt.px(190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment?.u?.userName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Adapt.px(28),
                      ),
                    ),
                    Spacer(),
                    Text(
                      _timeline,
                      style: TextStyle(
                        fontSize: Adapt.px(18),
                        color: const Color(0xFF717171),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Adapt.px(20)),
                Text(comment?.comment ?? ''),
                SizedBox(height: Adapt.px(30)),
                Divider()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentPanel extends StatelessWidget {
  final double height;
  final ScrollController scrollController;
  final TvShowComments comments;
  const _CommentPanel({this.comments, this.height, this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: Adapt.px(40),
        vertical: Adapt.px(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Comments',
                style: TextStyle(
                  fontSize: Adapt.px(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ],
          )),
          SizedBox(height: Adapt.px(40)),
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: Adapt.px(110)),
              separatorBuilder: (_, __) => SizedBox(height: Adapt.px(30)),
              itemCount: comments?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final _d = comments.data[index];
                return _CommentCell(comment: _d);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInputCell extends StatefulWidget {
  final double pageHeight;
  final Function(String) submit;
  final ScrollController scrollController;
  const _CommentInputCell(
      {this.pageHeight, this.submit, this.scrollController});
  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<_CommentInputCell> {
  bool _show = true;
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.scrollController != null)
      widget.scrollController?.position?.isScrollingNotifier
          ?.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_scrollListener);
    _controller?.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final _f = !widget.scrollController.position.isScrollingNotifier.value;
    if (_f != _show)
      setState(() {
        _show = _f;
      });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Transform.translate(
        offset: Offset(0, -widget.pageHeight),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (widget, animation) {
            return SlideTransition(
              position:
                  animation.drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
              child: widget,
            );
          },
          child: _show
              ? Container(
                  decoration: BoxDecoration(
                      color: _theme.backgroundColor,
                      border: Border(
                          top: BorderSide(color: _theme.primaryColorDark))),
                  child: SafeArea(
                    top: false,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          color: _theme.primaryColorLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        onSubmitted: (s) {
                          widget.submit(s);
                          _controller.clear();
                        },
                        cursorColor: Colors.grey,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 16),
                          labelStyle: TextStyle(fontSize: 16),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Add a comment',
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
