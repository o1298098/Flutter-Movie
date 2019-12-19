import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/customcliper_path.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildAppBar() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text('Setting'),
      ),
    );
  }

  Widget _buildBackGround() {
    final CurvedAnimation _heightAnimation =
        CurvedAnimation(parent: state.pageAnimation, curve: Curves.ease);
    final Animation _height = Tween(begin: Adapt.px(380), end: Adapt.px(900))
        .animate(_heightAnimation);
    final CurvedAnimation _pathAnimation = CurvedAnimation(
        parent: state.pageAnimation,
        curve: Interval(0.4, 1.0, curve: Curves.ease));
    return AnimatedBuilder(
      animation: state.pageAnimation,
      builder: (_, __) {
        return ClipPath(
            clipper: CustomCliperPath(
                height: _height.value,
                width: Adapt.screenW(),
                radius: Tween(begin: Adapt.px(2000), end: Adapt.px(8000))
                    .animate(_pathAnimation)
                    .value),
            child: Container(
              height: _height.value,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      ColorTween(
                              begin: Color(0xFF6495ED), end: Color(0xFF111111))
                          .animate(_heightAnimation)
                          .value,
                      ColorTween(
                              begin: Color(0xFF6A5ACD), end: Color(0xFF111111))
                          .animate(_heightAnimation)
                          .value,
                      //Color(0xFF6495ED),
                      //Color(0xFF6A5ACD),
                      //Color(0xFF707070),
                      //Color(0xFF202020),
                    ],
                    stops: <double>[
                      0.0,
                      1.0
                    ]),
              ),
            ));
      },
    );
    ;
  }

  Widget _buildListCell(double begin, double end,
      {Color shadowColor = const Color(0xFF808080), @required Widget child}) {
    final CurvedAnimation _animation = CurvedAnimation(
        parent: state.pageAnimation,
        curve: Interval(begin, end, curve: Curves.ease));
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(_animation),
        child: SlideTransition(
            position: Tween(begin: Offset(0, 2), end: Offset.zero)
                .animate(_animation),
            child: Container(
              height: Adapt.px(250),
              margin: EdgeInsets.only(bottom: Adapt.px(40)),
              decoration: BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(Adapt.px(20)),
              ),
              child: child,
            )));
  }

  Widget _buildAvatarCell() {
    return _buildListCell(.1, .8,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(60)),
          child: ListTile(
            leading: Container(
              width: Adapt.px(80),
              height: Adapt.px(80),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          state.user?.photoUrl ?? ''))),
            ),
            title: Text(
              state.user?.displayName ?? 'Guest',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            subtitle: Text(
              state.user?.email ?? '-',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Colors.white,
              iconSize: Adapt.px(60),
            ),
          ),
        ));
  }

  Widget _buildAdultCell() {
    return _buildListCell(.2, .9,
        shadowColor: Color(0xFF303030),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(60)),
          child: ListTile(
            leading: Icon(
              Icons.visibility_off,
              color: Colors.white,
              size: Adapt.px(80),
            ),
            title: Text(
              'Adult Items',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            subtitle: Text(
              'off',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            trailing: CupertinoSwitch(
              onChanged: (b) {},
              activeColor: Color(0xFF111111),
              trackColor: Color(0xFF505050),
              value: false,
            ),
          ),
        ));
  }

  Widget _buildCachedCell() {
    return _buildListCell(.3, 1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(60)),
          child: ListTile(
            leading: Icon(
              Icons.storage,
              color: Colors.white,
              size: Adapt.px(80),
            ),
            title: Text(
              'Cached Storage',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            subtitle: Text(
              '3.5 MB',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete_outline),
              color: Colors.white,
              iconSize: Adapt.px(60),
            ),
          ),
        ));
  }

  Widget _buildBody() {
    final double _margin = Adapt.px(120) + Adapt.padTopH();
    return Container(
        margin: EdgeInsets.only(top: _margin),
        height: Adapt.screenH() - _margin,
        child: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
          shrinkWrap: true,
          children: <Widget>[
            _buildAvatarCell(),
            _buildAdultCell(),
            _buildCachedCell(),
          ],
        ));
  }

  return Scaffold(
    body: Stack(
      children: <Widget>[
        _buildBackGround(),
        _buildBody(),
        _buildAppBar(),
      ],
    ),
  );
}
