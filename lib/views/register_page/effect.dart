import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/pop_result.dart';
import 'package:movie/actions/user_info_operate.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<RegisterPageState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterPageState>>{
    RegisterPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    RegisterPageAction.registerWithEmail: _onRegisterWithEmail
  });
}

void _onAction(Action action, Context<RegisterPageState> ctx) {}

void _onInit(Action action, Context<RegisterPageState> ctx) {
  ctx.state.emailFocusNode = FocusNode();
  ctx.state.nameFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();
  ctx.state.emailTextController = TextEditingController();
  ctx.state.nameTextController = TextEditingController();
  ctx.state.passWordTextController = TextEditingController();
  final Object ticker = ctx.stfState;
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
}

void _onDispose(Action action, Context<RegisterPageState> ctx) {
  ctx.state.emailFocusNode.dispose();
  ctx.state.nameFocusNode.dispose();
  ctx.state.passWordTextController.dispose();
  ctx.state.pwdFocusNode.dispose();
  ctx.state.nameTextController.dispose();
  ctx.state.emailTextController.dispose();
  ctx.state.submitAnimationController.dispose();
}

void _onRegisterWithEmail(Action action, Context<RegisterPageState> ctx) async {
  if (ctx.state.nameTextController.text == '' ||
      ctx.state.emailTextController.text == '' ||
      ctx.state.passWordTextController.text == '') {
    Toast.show('Please enter all information', ctx.context,
        duration: 3, gravity: Toast.BOTTOM);
  } else {
    try {
      ctx.state.submitAnimationController.forward();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: ctx.state.emailTextController.text,
              password: ctx.state.passWordTextController.text))
          .user;
      if (user != null) {
        assert(ctx.state.nameTextController.text != '');
        user.sendEmailVerification();
        final UserUpdateInfo userUpdateInfo = UserUpdateInfo()
          ..displayName = ctx.state.nameTextController.text;
        user.updateProfile(userUpdateInfo).then((d) {
          UserInfoOperate.whenLogin(user, ctx.state.nameTextController.text);
          Navigator.pop(
            ctx.context,
            PopWithResults(
              fromPage: "registerPage",
              toPage: 'mainpage',
              results: {'s': true, 'name': ctx.state.nameTextController.text},
            ),
          );
        });
      }
    } on Exception catch (e) {
      ctx.state.submitAnimationController.reverse();
      Toast.show(e.toString(), ctx.context, duration: 3, gravity: Toast.BOTTOM);
    }
  }
}
