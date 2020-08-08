import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/style/themestyle.dart';
import 'dart:math' as math;

import 'state.dart';

Widget buildView(
    AccountState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 35),
      children: [
        _UserInfo(
          profileUrl: state.user?.firebaseUser?.photoUrl,
          userName: state.user?.firebaseUser?.displayName,
        ),
        _SecondPanel(),
        _ThirdPanel()
      ],
    ),
  );
}

class _UserInfo extends StatelessWidget {
  final String userName;
  final String profileUrl;
  const _UserInfo({this.profileUrl, this.userName});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(children: [
          Icon(
            FontAwesomeIcons.bell,
            color: const Color(0xFF717171),
            size: 20,
          ),
          Spacer(),
          Text(
            userName ?? 'UserName',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _theme.primaryColorDark,
              borderRadius: BorderRadius.circular(10),
              image: profileUrl == null
                  ? null
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(profileUrl),
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _SecondPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF3E3E3E),
            ),
          )
        ],
      ),
    );
  }
}

class _ThirdPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title3',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30),
          _FeaturesCell(
            title: "Favortes",
            subTitle: 'xxxxxxxxxxx xxxxx xxxxxxx',
            value: '5',
          ),
          _FeaturesCell(
              title: "Watch List",
              subTitle: 'xxx xxxxxxxx xxxxx xxxxxxx',
              value: '2',
              angle: 90),
          _FeaturesCell(
              title: "My List",
              subTitle: 'xxxxxxxx xxx xxxxx xxxxxxx',
              value: '8',
              angle: 180),
          _FeaturesCell(
              title: "Cast List",
              subTitle: 'xxxxxxxx xxx xxxxx xxxx xxx',
              value: '9',
              angle: 270),
          _FeaturesCell(
            title: "Download",
            subTitle: 'xxxx xxx xxxx xxxxx xxxxxxx',
          ),
        ],
      ),
    );
  }
}

class _FeaturesCell extends StatelessWidget {
  final double angle;
  final String subTitle;
  final String title;
  final String value;
  const _FeaturesCell(
      {this.angle = 0, @required this.title, this.subTitle, this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Transform.rotate(
            angle: angle * math.pi / 180,
            child: Image.asset(
              'images/option_icon_b.png',
              width: 50,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subTitle ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF717171),
                ),
              )
            ],
          ),
          Spacer(),
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF717171),
            ),
          )
        ],
      ),
    );
  }
}
