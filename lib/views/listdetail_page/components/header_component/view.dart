import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/sort_condition.dart';
import 'package:movie/views/listdetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return FlexibleSpaceBar(
    background: state.listid != null
        ? _Header(
            backGroundUrl: state.backGroundUrl,
            user: state.user,
            description: state.description,
            dispatch: dispatch,
            sortBy: state.sortBy,
          )
        : _ShimmerHeader(),
  );
}

class _ShimmerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color baseColor = const Color(0xFF505050);
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
                    _IconButton(icon: Icons.edit, onPress: () {}),
                    _IconButton(icon: Icons.share, onPress: () {}),
                    _IconButton(icon: Icons.sort, onPress: () {}),
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
}

class _IconButton extends StatelessWidget {
  final Function onPress;
  final IconData icon;
  const _IconButton({this.icon, this.onPress});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: const Color(0xFFFFFFFF)),
      onPressed: onPress,
    );
  }
}

class _Header extends StatelessWidget {
  final String backGroundUrl;
  final FirebaseUser user;
  final Dispatch dispatch;
  final List<SortCondition<dynamic>> sortBy;
  final String description;
  const _Header(
      {this.backGroundUrl,
      this.description,
      this.dispatch,
      this.sortBy,
      this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(backGroundUrl),
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
                        image: user.photoUrl != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    CachedNetworkImageProvider(user.photoUrl))
                            : null),
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
                          user.displayName ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _IconButton(
                      icon: Icons.share,
                      onPress: () => dispatch(
                          ListDetailPageActionCreator.showShareCard())),
                  PopupMenuButton<SortCondition>(
                    offset: Offset(0, Adapt.px(100)),
                    icon: Icon(Icons.sort, color: Colors.white),
                    onSelected: (selected) => dispatch(
                        ListDetailPageActionCreator.sortChanged(selected)),
                    itemBuilder: (ctx) {
                      return sortBy.map((s) {
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
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style:
                        TextStyle(color: Colors.white, fontSize: Adapt.px(26)),
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
  }
}
