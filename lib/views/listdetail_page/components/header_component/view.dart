import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/views/listdetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildIconButton(IconData icon, void onPress()) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPress,
    );
  }

  Widget _buildShimmerHeader() {
    Color baseColor = Color(0xFF505050);
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: Color(0xFF707070),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: Adapt.px(100)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: Adapt.px(100),
                      height: Adapt.px(100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(50)),
                          color: baseColor),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'A list by',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.px(30)),
                        ),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        Container(
                          width: Adapt.px(120),
                          height: Adapt.px(28),
                          color: baseColor,
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    _buildIconButton(Icons.edit, () {}),
                    _buildIconButton(Icons.share, () {}),
                    _buildIconButton(Icons.sort, () {}),
                  ],
                ),
                SizedBox(
                  height: Adapt.px(20),
                ),
                Text('About this list',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(30))),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(60),
                  height: Adapt.px(26),
                  color: baseColor,
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(60),
                  height: Adapt.px(26),
                  color: baseColor,
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(200),
                  height: Adapt.px(26),
                  color: baseColor,
                ),
                SizedBox(
                  height: Adapt.px(30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (state.listid != null)
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(state.backGroundUrl),
        )),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(Adapt.px(30)),
          color: Colors.black.withOpacity(0.7),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: Adapt.px(100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      width: Adapt.px(100),
                      height: Adapt.px(100),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(Adapt.px(50)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.user.photoUrl ?? ''))),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'A list by',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.px(30)),
                        ),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        SizedBox(
                          width: Adapt.px(200),
                          child: Text(
                            state.user.displayName ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    _buildIconButton(
                        Icons.share,
                        () => viewService.broadcast(
                            ListDetailPageActionCreator.showShareCard())),
                    PopupMenuButton<SortCondition>(
                      offset: Offset(0, Adapt.px(100)),
                      icon: Icon(Icons.sort, color: Colors.white),
                      onSelected: (selected) => dispatch(
                          ListDetailPageActionCreator.sortChanged(selected)),
                      itemBuilder: (ctx) {
                        return state.sortBy.map((s) {
                          final unSelectedStyle = TextStyle(color: Colors.grey);
                          final selectedStyle =
                              TextStyle(fontWeight: FontWeight.bold);
                          return PopupMenuItem<SortCondition>(
                            value: s,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  s.name,
                                  style: s.isSelected
                                      ? selectedStyle
                                      : unSelectedStyle,
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                s.isSelected ? Icon(Icons.check) : SizedBox()
                              ],
                            ),
                          );
                        }).toList();
                      },
                    )
                  ]),
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Text('About this list',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Adapt.px(30))),
                  Container(
                    width: Adapt.screenW() - Adapt.px(60),
                    height: Adapt.px(120),
                    child: Text(
                      state.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                          color: Colors.white, fontSize: Adapt.px(26)),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(30),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    else
      return _buildShimmerHeader();
  }

  return FlexibleSpaceBar(
    background: _buildHeader(),
  );
}
