import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:movie/actions/base_api.dart';
import 'package:movie/actions/pop_result.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:toast/toast.dart';
import 'action.dart';
import 'state.dart';

Effect<RegisterPageState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterPageState>>{
    RegisterPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    RegisterPageAction.registerWithEmail: _onRegisterWithEmail
  });
}

void _onAction(Action action, Context<RegisterPageState> ctx) {}

void _onInit(Action action, Context<RegisterPageState> ctx) {
  ctx.state.emailFocusNode = FocusNode();
  ctx.state.nameFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();

  final Object ticker = ctx.stfState;
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
}

void _onRegisterWithEmail(Action action, Context<RegisterPageState> ctx) async {
  if (ctx.state.name == null ||
      ctx.state.emailAddress == null ||
      ctx.state.password == null) {
    Toast.show('Please enter all information', ctx.context,
        duration: 3, gravity: Toast.BOTTOM);
  } else {
    try {
      ctx.state.submitAnimationController.forward();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: ctx.state.emailAddress, password: ctx.state.password))
          .user;
      if (user != null) {
        assert(ctx.state.name != null);
        final UserUpdateInfo userUpdateInfo = UserUpdateInfo()
          ..displayName = ctx.state.name;
        user.updateProfile(userUpdateInfo).then((d) {
          GlobalStore.store.dispatch(GlobalActionCreator.setUser(user));
          BaseApi.updateUser(user.uid, user.email, user.photoUrl,
              ctx.state.name, user.phoneNumber);
          Navigator.pop(
            ctx.context,
            PopWithResults(
              fromPage: "registerPage",
              toPage: 'mainpage',
              results: {'s': true, 'name': ctx.state.name},
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
