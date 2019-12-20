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
    final Animation _height = Tween(begin: Adapt.px(380), end: Adapt.px(1200))
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

  Widget _buildUserCell() {
    return _buildListCell(.1, .7,
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
              maxLines: 1,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(24)),
            ),
            trailing: IconButton(
              onPressed: () => state.userEditAnimation.forward(),
              icon: Icon(Icons.edit),
              color: Colors.white,
              iconSize: Adapt.px(60),
            ),
          ),
        ));
  }

  Widget _buildAdultCell() {
    return _buildListCell(.2, .8,
        shadowColor: Color(0xFF303030),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(60)),
          child: ListTile(
            onTap: () => dispatch(SettingPageActionCreator.adultCellTapped()),
            leading: Icon(
              state.adultSwitchValue ? Icons.visibility : Icons.visibility_off,
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
              state.adultSwitchValue ? 'on' : 'off',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            trailing: CupertinoSwitch(
              onChanged: (b) =>
                  dispatch(SettingPageActionCreator.adultCellTapped()),
              activeColor: Color(0xFF111111),
              trackColor: Color(0xFFD0D0D0),
              value: state.adultSwitchValue,
            ),
          ),
        ));
  }

  Widget _buildCachedCell() {
    return _buildListCell(.3, .9,
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
              '${state.cachedSize.toStringAsFixed(2)} MB',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            trailing: IconButton(
              onPressed: () => dispatch(SettingPageActionCreator.cleanCached()),
              icon: Icon(Icons.delete_outline),
              color: Colors.white,
              iconSize: Adapt.px(60),
            ),
          ),
        ));
  }

  Widget _buildVersionCell() {
    return _buildListCell(.4, 1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(30), vertical: Adapt.px(60)),
          child: ListTile(
            leading: Icon(
              Icons.system_update,
              color: Colors.white,
              size: Adapt.px(80),
            ),
            title: Text(
              'Version',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            subtitle: Text(
              '1.0',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35)),
            ),
            trailing: IconButton(
              onPressed: () => dispatch(SettingPageActionCreator.cleanCached()),
              icon: Icon(Icons.refresh),
              color: Colors.white,
              iconSize: Adapt.px(60),
            ),
          ),
        ));
  }

  Widget _buildBody() {
    final double _margin = Adapt.px(120) + Adapt.padTopH();
    final Animation _run = Tween(begin: .00, end: 1.0).animate(
        CurvedAnimation(parent: state.userEditAnimation, curve: Curves.ease));
    return AnimatedBuilder(
      animation: state.userEditAnimation,
      builder: (_, __) {
        return Padding(
            padding: EdgeInsets.only(
                top: _margin, left: Adapt.px(60), right: Adapt.px(60)),
            child: Container(
                transform: Matrix4.identity()
                  ..scale(1.0 - _run.value, 1.0, 1.0),
                height: Adapt.screenH() - _margin,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  //padding: EdgeInsets.symmetric(horizontal: Adapt.px(60)),
                  shrinkWrap: true,
                  children: <Widget>[
                    _buildUserCell(),
                    _buildAdultCell(),
                    _buildCachedCell(),
                    _buildVersionCell()
                  ],
                )));
      },
    );
  }

  Widget _buildButtonGrounp() {
    return Padding(
        padding: EdgeInsets.all(Adapt.px(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => state.userEditAnimation.reverse(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                height: Adapt.px(80),
                width: Adapt.px(200),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Adapt.px(40)),
                    border: Border.all(color: Colors.white, width: 3)),
                child: Center(
                    child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Adapt.px(35),
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
            SizedBox(width: Adapt.px(60)),
            InkWell(
              onTap: () => state.userEditAnimation.reverse(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                height: Adapt.px(80),
                width: Adapt.px(200),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Adapt.px(40)),
                    border: Border.all(color: Colors.white, width: 3)),
                child: Center(
                    child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Adapt.px(35),
                      fontWeight: FontWeight.w500),
                )),
              ),
            )
          ],
        ));
  }

  Widget _buildTextFields() {
    return Padding(
        padding:
            EdgeInsets.fromLTRB(Adapt.px(40), Adapt.px(60), Adapt.px(40), 0),
        child: Column(
          children: <Widget>[
            Container(
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(40)),
                color: Color(0xFF353535),
              ),
            ),
            SizedBox(height: Adapt.px(30)),
            Container(
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(40)),
                color: Color(0xFF353535),
              ),
            ),
            SizedBox(height: Adapt.px(30)),
            Container(
              height: Adapt.px(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.px(40)),
                color: Color(0xFF353535),
              ),
            )
          ],
        ));
  }

  Widget _buildUserProfilePanel() {
    final double _margin = Adapt.px(120) + Adapt.padTopH();
    final CurvedAnimation _run =
        CurvedAnimation(parent: state.userEditAnimation, curve: Curves.ease);
    return AnimatedBuilder(
        animation: state.userEditAnimation,
        builder: (_, __) {
          return Padding(
              padding:
                  EdgeInsets.fromLTRB(Adapt.px(40), _margin, Adapt.px(40), 0),
              child: SlideTransition(
                  position: Tween(begin: Offset(1, 0.0), end: Offset.zero)
                      .animate(_run),
                  child: Container(
                    transform: Matrix4.identity()..scale(_run.value, 1.0, 1.0),
                    margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
                    width: Adapt.screenH() - Adapt.px(120),
                    height: Adapt.px(1120),
                    decoration: BoxDecoration(
                        color: Color(0xFF202020),
                        borderRadius: BorderRadius.circular(Adapt.px(20))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: Adapt.px(60)),
                        Container(
                          width: Adapt.px(150),
                          height: Adapt.px(150),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                        _buildTextFields(),
                        Expanded(child: SizedBox()),
                        _buildButtonGrounp(),
                      ],
                    ),
                  )));
        });
  }

  return Scaffold(
    body: Stack(
      children: <Widget>[
        _buildBackGround(),
        _buildBody(),
        _buildUserProfilePanel(),
        _buildAppBar(),
      ],
    ),
  );
}
