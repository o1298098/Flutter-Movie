import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
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
}

void _onRegisterWithEmail(Action action, Context<RegisterPageState> ctx) async {
  assert(ctx.state.emailAddress != null);
  assert(ctx.state.password != null);
  try {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: ctx.state.emailAddress, password: ctx.state.password))
        .user;
    if (user != null) {
      assert(ctx.state.name != null);
      final UserUpdateInfo userUpdateInfo = UserUpdateInfo()
        ..displayName = ctx.state.name;
      await user.updateProfile(userUpdateInfo);
    }
  } on Exception catch (e) {
    Toast.show(e.toString(), ctx.context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}
