import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/actions/pop_result.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/views/register_page/page.dart';
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

final FirebaseAuth _auth = FirebaseAuth.instance;
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
  AuthResult result;
  ctx.state.submitAnimationController.forward();
  if (ctx.state.account != '' && ctx.state.pwd != '') {
    //result = await ApiHelper.createSessionWithLogin(/ctx.state.account, ctx.state.pwd);
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: ctx.state.account, password: ctx.state.pwd);
    } on Exception catch (e) {
      Toast.show(e.toString(), ctx.context, duration: 3, gravity: Toast.BOTTOM);
      ctx.state.submitAnimationController.reverse();
    }
  }
  if (result?.user == null) {
    Toast.show("Account verification required", ctx.context,
        duration: 3, gravity: Toast.BOTTOM);
    ctx.state.submitAnimationController.reverse();
  } else {
    var user = result?.user;
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(user));
    BaseApi.updateUser(user.uid, user.email, user.photoUrl, user.displayName,
        user.phoneNumber);
    Navigator.of(ctx.context).pop({'s': true, 'name': user.displayName});
  }
}

Future _onSignUp(Action action, Context<LoginPageState> ctx) async {
  /*var url = 'https://www.themoviedb.org/account/signup';
  if (await canLaunch(url)) {
    await launch(url);
  }*/
  //await Navigator.of(ctx.context).pushNamed('registerPage');
  Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (context, an, _) {
    return FadeTransition(
      opacity: an,
      child: RegisterPage().buildPage(null),
    );
  })).then((results) {
    if (results is PopWithResults) {
      PopWithResults popResult = results;
      if (popResult.toPage == 'mainpage')
        Navigator.of(ctx.context).pop(results.results);
    }
  });
}

void _onGoogleSignIn(Action action, Context<LoginPageState> ctx) async {
  ctx.state.submitAnimationController.forward();
  try {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(user));
      BaseApi.updateUser(user.uid, user.email, user.photoUrl, user.displayName,
          user.phoneNumber);
      Navigator.of(ctx.context).pop({'s': true, 'name': user.displayName});
    } else {
      ctx.state.submitAnimationController.reverse();
      Toast.show("Google signIn fail", ctx.context,
          duration: 3, gravity: Toast.BOTTOM);
    }
  } on Exception catch (e) {
    ctx.state.submitAnimationController.reverse();
    Toast.show(e.toString(), ctx.context, duration: 5, gravity: Toast.BOTTOM);
  }
}
