import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/movie_stream_link.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/stream_link_page/livestream_page/action.dart';

import 'state.dart';

Widget buildView(
    StreamLinkState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(Adapt.px(30), 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Stream Links',
                  style: TextStyle(
                      fontSize: Adapt.px(40), fontWeight: FontWeight.w500),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  onSelected: (d) {
                    if (d == 'report')
                      dispatch(LiveStreamPageActionCreator.streamLinkReport());
                  },
                  itemBuilder: (_) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        value: 'report',
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.flag),
                            SizedBox(width: Adapt.px(20)),
                            Text('report')
                          ],
                        ),
                      )
                    ];
                  },
                ),
              ],
            )),
        SizedBox(height: Adapt.px(30)),
        SizedBox(
            height: Adapt.px(130),
            child: state.streamLinks.length > 0
                ? ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
                    itemCount: state.streamLinks.length,
                    itemBuilder: (_, index) {
                      final d = state.streamLinks[index];
                      return _StreamLinkCell(
                        data: d,
                        onTap: () {
                          if (!d.selected)
                            dispatch(
                                LiveStreamPageActionCreator.chipSelected(d));
                        },
                      );
                    })
                : _ShimmerList()),
        SizedBox(height: Adapt.px(30))
      ],
    ),
  );
}

class _StreamLinkCell extends StatelessWidget {
  final MovieStreamLink data;
  final Function onTap;
  const _StreamLinkCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Adapt.px(300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          border: Border.all(
              color: data.selected
                  ? MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white
                  : Colors.grey),
        ),
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.all(Adapt.px(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${data.linkName}'),
                    SizedBox(height: Adapt.px(15)),
                    Text(
                      '${data.language.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: Colors.grey, fontSize: Adapt.px(30)),
                    ),
                  ],
                ),
                Container(
                  height: Adapt.px(45),
                  padding: EdgeInsets.all(Adapt.px(10)),
                  decoration: BoxDecoration(
                      color: Color(0xFF505050),
                      borderRadius: BorderRadius.circular(Adapt.px(25))),
                  child: Text(
                    data.quality.name,
                    style:
                        TextStyle(color: Colors.white, fontSize: Adapt.px(20)),
                  ),
                )
              ],
            ),
          ),
          data.needAd
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xAA60ABBA),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Adapt.px(19)),
                            bottomRight: Radius.circular(Adapt.px(19)))),
                    width: Adapt.px(60),
                    height: Adapt.px(40),
                    child: Center(
                        child: Text(
                      'Ad',
                      style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: Adapt.px(18)),
                    )),
                  ))
              : SizedBox(),
        ]),
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
      itemCount: 3,
      itemBuilder: (_, index) => Container(
        width: Adapt.px(300),
        decoration: BoxDecoration(
          color: _theme.primaryColorLight,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
        ),
      ),
    );
  }
}
