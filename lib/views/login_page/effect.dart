import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';
import 'package:toast/toast.dart';

Effect<LoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<LoginPageState>>{
    LoginPageAction.action: _onAction,
    LoginPageAction.loginclicked: _onLoginClicked,
    LoginPageAction.signUp: _onSignUp,
    LoginPageAction.googleSignIn: _onGoogleSignIn,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

void _onInit(Action action, Context<LoginPageState> ctx) {
  ctx.state.accountFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
}

void _onBuild(Action action, Context<LoginPageState> ctx) {
  Future.delayed(Duration(milliseconds: 150),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<LoginPageState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.accountFocusNode.dispose();
  ctx.state.pwdFocusNode.dispose();
  ctx.state.submitAnimationController.dispose();
}

void _onAction(Action action, Context<LoginPageState> ctx) {}

Future _onLoginClicked(Action action, Context<LoginPageState> ctx) async {
  bool result = false;
  ctx.state.submitAnimationController.forward();
  if (ctx.state.account != '' && ctx.state.pwd != '') {
    result = await ApiHelper.createSessionWithLogin(
        ctx.state.account, ctx.state.pwd);
  }
  if (!result) {
    Toast.show("Account verification required", ctx.context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    ctx.state.submitAnimationController.reverse();
  } else {
    Navigator.of(ctx.context).pop(true);
  }
}

Future _onSignUp(Action action, Context<LoginPageState> ctx) async {
  var url = 'https://www.themoviedb.org/account/signup';
  if (await canLaunch(url)) {
    await launch(url);
  }
  //await Navigator.of(ctx.context).pushNamed('registerPage');
}

void _onGoogleSignIn(Action action, Context<LoginPageState> ctx) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  assert(user.email != null);
  assert(user.displayName != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  if (user != null) {
    Navigator.of(ctx.context).pop(true);
  } else
    Toast.show("Google signIn fail", ctx.context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}
