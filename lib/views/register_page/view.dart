import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/customwidgets/customcliper_path.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterPageState state, Dispatch dispatch, ViewService viewService) {
  final double headerHeight = Adapt.screenH() / 3;
  Widget _buildHeader() {
    return ClipPath(
      clipper: CustomCliperPath(
          height: headerHeight, width: Adapt.screenW(), radius: Adapt.px(1000)),
      child: Container(
        height: headerHeight,
        width: Adapt.screenW(),
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    'https://image.tmdb.org/t/p/original/mAkPFEWkwKz9nmKyCiuETfTdpgX.jpg'))),
        alignment: Alignment.center,
        child: Container(
            color: Color.fromRGBO(20, 20, 20, 0.8),
            alignment: Alignment.center,
            height: headerHeight,
            width: Adapt.screenW(),
            child: Image.asset(
              'images/tmdb_blue.png',
              width: Adapt.px(150),
              height: Adapt.px(150),
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _buildSubmit() {
    var submitWidth = CurvedAnimation(
      parent: state.submitAnimationController,
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    );
    var loadCurved = CurvedAnimation(
      parent: state.submitAnimationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.ease,
      ),
    );
    return new AnimatedBuilder(
      animation: state.submitAnimationController,
      builder: (ctx, w) {
        double buttonWidth = Adapt.screenW() * 0.8;
        return Container(
          margin: EdgeInsets.only(top: Adapt.px(60)),
          height: Adapt.px(100),
          child: Stack(
            children: <Widget>[
              Container(
                height: Adapt.px(100),
                width: Tween<double>(begin: buttonWidth, end: Adapt.px(100))
                    .animate(submitWidth)
                    .value,
                child: FlatButton(
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: Text('Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Tween<double>(begin: Adapt.px(35), end: 0.0)
                              .animate(submitWidth)
                              .value)),
                  onPressed: () =>
                      dispatch(RegisterPageActionCreator.onRegisterWithEmail()),
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(loadCurved),
                child: Container(
                  width: Adapt.px(100),
                  height: Adapt.px(100),
                  padding: EdgeInsets.all(Adapt.px(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildRegisterForm() {
    return Center(
      child: Form(
        child: Card(
          elevation: 10,
          child: Container(
            height: Adapt.screenH() / 2,
            width: Adapt.screenW() * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(Adapt.px(40)),
                    child: TextFormField(
                      focusNode: state.nameFocusNode,
                      style: TextStyle(fontSize: Adapt.px(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Nickname',
                          hasFloatingPlaceholder: true,
                          filled: true,
                          prefixStyle: TextStyle(
                              color: Colors.black, fontSize: Adapt.px(35)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black87))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (t) => dispatch(
                          RegisterPageActionCreator.onNameTextChanged(t)),
                    )),
                Padding(
                    padding: EdgeInsets.all(Adapt.px(40)),
                    child: TextFormField(
                      focusNode: state.emailFocusNode,
                      style: TextStyle(fontSize: Adapt.px(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Email',
                          hasFloatingPlaceholder: true,
                          filled: true,
                          prefixStyle: TextStyle(
                              color: Colors.black, fontSize: Adapt.px(35)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black87))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (t) => dispatch(
                          RegisterPageActionCreator.onEmailTextChanged(t)),
                    )),
                Padding(
                    padding: EdgeInsets.all(Adapt.px(40)),
                    child: TextFormField(
                      obscureText: true,
                      focusNode: state.pwdFocusNode,
                      style: TextStyle(fontSize: Adapt.px(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Password',
                          hasFloatingPlaceholder: true,
                          filled: true,
                          prefixStyle: TextStyle(
                              color: Colors.black, fontSize: Adapt.px(35)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black87))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (t) => dispatch(
                          RegisterPageActionCreator.onPwdTextChanged(t)),
                    )),
                _buildSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  return Scaffold(
    body: Stack(
      children: <Widget>[_buildHeader(), _buildRegisterForm(), _buildAppBar()],
    ),
  );
}
