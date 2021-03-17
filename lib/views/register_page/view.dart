import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/customcliper_path.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[
        _Header(),
        _RegisterForm(
          dispatch: dispatch,
          emailTextController: state.emailTextController,
          nameTextController: state.nameTextController,
          emailFocusNode: state.emailFocusNode,
          nameFocusNode: state.nameFocusNode,
          passWordTextController: state.passWordTextController,
          pwdFocusNode: state.pwdFocusNode,
          submitAnimationController: state.submitAnimationController,
        ),
        _AppBar(),
      ],
    ),
  );
}

class _Header extends StatelessWidget {
  final double headerHeight = Adapt.screenH() / 3;
  @override
  Widget build(BuildContext context) {
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
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class _SubmitButton extends StatelessWidget {
  final AnimationController controller;
  final Function onSubimt;
  const _SubmitButton({this.controller, this.onSubimt});
  @override
  Widget build(BuildContext context) {
    final submitWidth = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    );
    final loadCurved = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.ease,
      ),
    );
    return AnimatedBuilder(
      animation: controller,
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
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Adapt.px(50)))),
                  child: Text('Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Tween<double>(begin: Adapt.px(35), end: 0.0)
                              .animate(submitWidth)
                              .value)),
                  onPressed: onSubimt,
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
}

class _RegisterForm extends StatelessWidget {
  final Dispatch dispatch;
  final TextEditingController nameTextController;
  final TextEditingController passWordTextController;
  final TextEditingController emailTextController;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode pwdFocusNode;
  final AnimationController submitAnimationController;
  const _RegisterForm(
      {this.dispatch,
      this.emailFocusNode,
      this.emailTextController,
      this.nameFocusNode,
      this.nameTextController,
      this.passWordTextController,
      this.pwdFocusNode,
      this.submitAnimationController});
  @override
  Widget build(BuildContext context) {
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
                      controller: nameTextController,
                      focusNode: nameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: Adapt.px(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Nickname',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      onFieldSubmitted: (_) => nameFocusNode.nextFocus(),
                    )),
                Padding(
                    padding: EdgeInsets.all(Adapt.px(40)),
                    child: TextFormField(
                      controller: emailTextController,
                      focusNode: emailFocusNode,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: Adapt.px(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                      onFieldSubmitted: (_) => emailFocusNode.nextFocus(),
                    )),
                Padding(
                    padding: EdgeInsets.all(Adapt.px(40)),
                    child: TextFormField(
                      obscureText: true,
                      controller: passWordTextController,
                      focusNode: pwdFocusNode,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: Adapt.px(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                    )),
                _SubmitButton(
                  controller: submitAnimationController,
                  onSubimt: () =>
                      dispatch(RegisterPageActionCreator.onRegisterWithEmail()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
