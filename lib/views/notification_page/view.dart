import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/local_notification.dart';
import 'package:movie/models/notification_model.dart';
import 'package:movie/style/themestyle.dart';

import 'dart:ui' as ui;
import 'action.dart';
import 'state.dart';

Widget buildView(
    NotificationState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      final _lenght = state.notificationList?.notifications?.length ?? 0;
      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Notifications',
            style: TextStyle(color: _theme.iconTheme.color),
          ),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: _theme.backgroundColor,
          iconTheme: _theme.iconTheme,
          brightness: _theme.brightness,
          actions: [
            _SearchButton(
              onTap: () async {
                await LocalNotification.instance
                    .sendNotification('title', 'body');
              },
            )
          ],
        ),
        body: _lenght > 0
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: Adapt.px(40), vertical: Adapt.px(30)),
                separatorBuilder: (_, index) => SizedBox(height: Adapt.px(40)),
                itemCount: state.notificationList?.notifications?.length ?? 0,
                itemBuilder: (_, index) {
                  return _ItemCell(
                    data: state
                        .notificationList?.notifications[_lenght - 1 - index],
                    onTap: (d) =>
                        dispatch(NotificationActionCreator.cellTapped(d)),
                  );
                },
              )
            : const _EmtypList(),
      );
    },
  );
}

class _SearchButton extends StatelessWidget {
  final Function onTap;
  const _SearchButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        child: Icon(Icons.search),
      ),
    );
  }
}

class _ItemCell extends StatefulWidget {
  final NotificationModel data;
  final Function(NotificationModel) onTap;
  const _ItemCell({this.data, this.onTap});
  @override
  _ItemCellState createState() => _ItemCellState();
}

class _ItemCellState extends State<_ItemCell> {
  final GlobalKey _key = GlobalKey();
  double _height = 0;
  _getSizes(_) {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    final size = renderBox.size;
    _height = size.height;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final DateTime _date = DateTime.parse(widget.data.date);
    final String timeline = TimelineUtil.format(
      _date.millisecondsSinceEpoch,
      locTimeMs: DateTime.now().millisecondsSinceEpoch,
      locale: ui.window.locale.languageCode,
    );
    return GestureDetector(
      onTap: () => widget.onTap(widget.data),
      child: Container(
        decoration: BoxDecoration(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFFF5F7FB)
              : _theme.primaryColorLight,
          borderRadius: BorderRadius.circular(Adapt.px(30)),
        ),
        child: Stack(children: [
          Row(
            children: [
              Container(
                key: _key,
                width: Adapt.screenW() - Adapt.px(240),
                padding: EdgeInsets.all(Adapt.px(40)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeline,
                      style: TextStyle(
                        fontSize: Adapt.px(22),
                        color: const Color(0xFF717171),
                      ),
                    ),
                    SizedBox(height: Adapt.px(15)),
                    Text(
                      widget.data.notification?.body ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Adapt.px(24),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              widget.data.posterPic != null
                  ? Container(
                      width: Adapt.px(160),
                      height: _height,
                      decoration: BoxDecoration(
                        color: _theme.primaryColorDark,
                        borderRadius: BorderRadius.circular(Adapt.px(30)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              CachedNetworkImageProvider(widget.data.posterPic),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          _CircleDot(read: widget.data.read),
        ]),
      ),
    );
  }
}

class _CircleDot extends StatelessWidget {
  final bool read;
  const _CircleDot({this.read});
  @override
  Widget build(BuildContext context) {
    return read
        ? const SizedBox()
        : Transform.translate(
            offset: Offset(-Adapt.px(3), -Adapt.px(3)),
            child: Container(
              width: Adapt.px(20),
              height: Adapt.px(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
            ),
          );
  }
}

class _EmtypList extends StatelessWidget {
  const _EmtypList();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: const Text(
        'Empty List',
        style: TextStyle(
          fontSize: 20,
          color: const Color(0xFF9E9E9E),
        ),
      ),
    ));
  }
}
