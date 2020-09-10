import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

import 'dart:ui' as ui;
import 'action.dart';
import 'state.dart';

Widget buildView(
    ListCellState state, Dispatch dispatch, ViewService viewService) {
  final d = state.cellData;
  final animate = TweenSequence([
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: 0.003, end: 0.0), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: -0.003, end: 0.0), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: 0.003, end: 0.0), weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: -0.003), weight: 0.5),
    TweenSequenceItem(tween: Tween<double>(begin: -0.003, end: 0.0), weight: 1),
  ]);

  Widget _buildListCell() {
    var date = DateTime.parse(d.updateTime);
    return RotationTransition(
      turns: animate.animate(CurvedAnimation(
          parent: state.cellAnimationController, curve: Curves.ease)),
      child: GestureDetector(
        onTap: () {
          if (!state.isEdit) dispatch(ListCellActionCreator.cellTapped(d));
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
          child: Container(
            height: Adapt.px(400),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(30)),
                color: Colors.grey[200],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(d.backGroundUrl))),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(30)),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          d.listName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Adapt.px(45),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: Adapt.px(15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('${d.itemCount} Items',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Adapt.px(30),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            SizedBox(
                              width: Adapt.px(20),
                            ),
                            Container(
                              padding: EdgeInsets.all(Adapt.px(8)),
                              decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius:
                                      BorderRadius.circular(Adapt.px(10))),
                              child: Text(
                                'PUBLIC',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adapt.px(24)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Adapt.px(8),
                        ),
                        Text(
                          'Updated ' +
                              TimelineUtil.format(
                                date.millisecondsSinceEpoch,
                                locTimeMs:
                                    DateTime.now().millisecondsSinceEpoch,
                                locale: ui.window.locale.languageCode,
                              ),
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: Adapt.px(28),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    state.isEdit
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () => dispatch(
                                    ListCellActionCreator.deleteList(d)),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.white),
                                onPressed: () => dispatch(
                                    ListCellActionCreator.onEdit(
                                        d: {'list': d})),
                              ),
                            ],
                          )
                        : Container()
                  ],
                )),
          ),
        ),
      ),
    );
  }

  return _buildListCell();
}
