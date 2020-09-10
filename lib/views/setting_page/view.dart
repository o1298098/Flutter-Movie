import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/customcliper_path.dart';
import 'action.dart';
import 'components/setting_body.dart';
import 'state.dart';

Widget buildView(
    SettingPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        _BackGround(pageAnimation: state.pageAnimation),
        SettingBody(
          dispatch: dispatch,
          pageAnimation: state.pageAnimation,
          userEditAnimation: state.userEditAnimation,
          adultSwitchValue: state.adultSwitchValue,
          loading: state.loading,
          cachedSize: state.cachedSize,
          version: state.version,
          user: state.user,
          appLanguage: state.appLanguage,
        ),
        _UserProfilePanel(
          dispatch: dispatch,
          user: state.user,
          phoneController: state.phoneController,
          photoController: state.photoController,
          userNameController: state.userNameController,
          userEditAnimation: state.userEditAnimation,
          userPanelPhotoUrl: state.userPanelPhotoUrl,
        ),
        _LoadingPanel(uploading: state.uploading),
        const _AppBar(),
      ],
    ),
  );
}

class _AppBar extends StatelessWidget {
  const _AppBar();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
      ),
    );
  }
}

class _BackGround extends StatelessWidget {
  final AnimationController pageAnimation;
  const _BackGround({this.pageAnimation});
  @override
  Widget build(BuildContext context) {
    final CurvedAnimation _heightAnimation =
        CurvedAnimation(parent: pageAnimation, curve: Curves.ease);
    final Animation _height = Tween(begin: Adapt.px(380), end: Adapt.px(1200))
        .animate(_heightAnimation);
    final CurvedAnimation _pathAnimation = CurvedAnimation(
        parent: pageAnimation, curve: Interval(0.4, 1.0, curve: Curves.ease));
    return AnimatedBuilder(
      animation: pageAnimation,
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
                            begin: const Color(0xFF6495ED),
                            end: const Color(0xFF111111))
                        .animate(_heightAnimation)
                        .value,
                    ColorTween(
                            begin: const Color(0xFF6A5ACD),
                            end: const Color(0xFF111111))
                        .animate(_heightAnimation)
                        .value,
                  ],
                  stops: <double>[
                    0.0,
                    1.0
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingPanel extends StatelessWidget {
  final bool uploading;
  const _LoadingPanel({@required this.uploading});
  @override
  Widget build(BuildContext context) {
    return uploading
        ? Container(
            width: Adapt.screenW(),
            height: Adapt.screenH(),
            color: Colors.black38,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          )
        : SizedBox();
  }
}

class _ButtonGrounp extends StatelessWidget {
  final AnimationController userEditAnimation;
  final Function submit;
  const _ButtonGrounp({this.submit, this.userEditAnimation});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Adapt.px(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => userEditAnimation.reverse(),
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
            onTap: submit,
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _UserProfileAvatar extends StatelessWidget {
  final Function onTap;
  final String userPanelPhotoUrl;
  const _UserProfileAvatar({this.onTap, this.userPanelPhotoUrl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Adapt.px(150),
        height: Adapt.px(150),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF303030),
            image: userPanelPhotoUrl != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(userPanelPhotoUrl),
                  )
                : null,
          ),
          child: Container(
            width: Adapt.px(150),
            height: Adapt.px(150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black38,
            ),
            child: Icon(Icons.file_upload, color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

class _TextFieldCell extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  const _TextFieldCell({this.controller, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: Adapt.px(35),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: Adapt.px(20)),
        Container(
          height: Adapt.px(80),
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.px(20)),
            color: Color(0xFF353535),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white, fontSize: Adapt.px(26)),
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _TextFields extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController photoController;
  final TextEditingController phoneController;
  const _TextFields(
      {this.phoneController, this.photoController, this.userNameController});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.fromLTRB(Adapt.px(40), Adapt.px(80), Adapt.px(40), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TextFieldCell(title: 'UserName', controller: userNameController),
            SizedBox(height: Adapt.px(40)),
            _TextFieldCell(title: 'Phone', controller: phoneController),
            SizedBox(height: Adapt.px(40)),
            _TextFieldCell(title: 'PhotoUrl', controller: photoController),
          ],
        ));
  }
}

class _UserProfilePanel extends StatelessWidget {
  final AnimationController userEditAnimation;
  final String userPanelPhotoUrl;
  final TextEditingController userNameController;
  final TextEditingController photoController;
  final TextEditingController phoneController;
  final Dispatch dispatch;
  final FirebaseUser user;
  const _UserProfilePanel(
      {this.dispatch,
      this.phoneController,
      this.photoController,
      this.user,
      this.userEditAnimation,
      this.userNameController,
      this.userPanelPhotoUrl});
  @override
  Widget build(BuildContext context) {
    final double _margin = Adapt.px(120) + Adapt.padTopH();
    final CurvedAnimation _run =
        CurvedAnimation(parent: userEditAnimation, curve: Curves.ease);
    return AnimatedBuilder(
      animation: userEditAnimation,
      builder: (_, __) {
        return Padding(
          padding: EdgeInsets.fromLTRB(Adapt.px(40), _margin, Adapt.px(40), 0),
          child: SlideTransition(
            position:
                Tween(begin: Offset(1, 0.0), end: Offset.zero).animate(_run),
            child: Container(
              transform: Matrix4.identity()..scale(_run.value, 1.0, 1.0),
              margin: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
              width: Adapt.screenH() - Adapt.px(120),
              height: Adapt.px(1120),
              decoration: BoxDecoration(
                  color: Color(0xFF202020),
                  borderRadius: BorderRadius.circular(Adapt.px(20))),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: Adapt.px(60)),
                  _UserProfileAvatar(
                    userPanelPhotoUrl: userPanelPhotoUrl,
                    onTap: () =>
                        dispatch(SettingPageActionCreator.openPhotoPicker()),
                  ),
                  SizedBox(height: Adapt.px(30)),
                  Text(
                    '${user?.email ?? '-'}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: Adapt.px(35)),
                  ),
                  _TextFields(
                    phoneController: phoneController,
                    photoController: photoController,
                    userNameController: userNameController,
                  ),
                  SizedBox(height: Adapt.px(60)),
                  _ButtonGrounp(
                    userEditAnimation: userEditAnimation,
                    submit: () =>
                        dispatch(SettingPageActionCreator.profileEdit()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
