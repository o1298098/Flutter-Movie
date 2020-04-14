import 'dart:convert';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/actions/pop_result.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/country_phone_code.dart';
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
    LoginPageAction.sendVerificationCode: _onSendVerificationCode,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

final FirebaseAuth _auth = FirebaseAuth.instance;
void _onInit(Action action, Context<LoginPageState> ctx) async {
  ctx.state..emailLogin = true;
  ctx.state.accountFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.accountTextController = TextEditingController();
  ctx.state.passWordTextController = TextEditingController();
  ctx.state.phoneTextController = TextEditingController();
  ctx.state.codeTextContraller = TextEditingController();
  ctx.state.countryCode = '+1';
  final _jsonStr = await CountryPhoneCode.getCountryJson(ctx.context);
  final countriesJson = json.decode(_jsonStr);
  ctx.state.countryCodes = List<CountryPhoneCode>();
  for (var country in countriesJson) {
    ctx.state.countryCodes.add(CountryPhoneCode.fromJson(country));
  }
  ctx.state.countryCode = ctx.state.countryCodes
          .singleWhere((e) => e.code == ui.window.locale.countryCode)
          ?.dialCode ??
      '+1';
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
  ctx.state.accountTextController.dispose();
  ctx.state.passWordTextController.dispose();
  ctx.state.phoneTextController.dispose();
  ctx.state.codeTextContraller.dispose();
}

void _onAction(Action action, Context<LoginPageState> ctx) {}

Future _onLoginClicked(Action action, Context<LoginPageState> ctx) async {
  AuthResult _result;
  ctx.state.submitAnimationController.forward();
  if (ctx.state.emailLogin)
    _result = await _emailSignIn(action, ctx);
  else
    _result = await _phoneNumSignIn(action, ctx);
  if (_result?.user == null) {
    Toast.show("Account verification required", ctx.context,
        duration: 3, gravity: Toast.BOTTOM);
    ctx.state.submitAnimationController.reverse();
  } else {
    var user = _result?.user;
    var _nickName = user.displayName ??
        user.phoneNumber.substring(user.phoneNumber.length - 4);

    if (user.displayName == null)
      user.updateProfile(UserUpdateInfo()..displayName = _nickName).then(
          (v) => GlobalStore.store.dispatch(GlobalActionCreator.setUser(user)));

    GlobalStore.store.dispatch(GlobalActionCreator.setUser(user));

    BaseApi.updateUser(
        user.uid, user.email, user.photoUrl, _nickName, user.phoneNumber);

    Navigator.of(ctx.context).pop({'s': true, 'name': _nickName});
  }
}

Future<AuthResult> _emailSignIn(
    Action action, Context<LoginPageState> ctx) async {
  if (ctx.state.accountTextController.text != '' &&
      ctx.state.passWordTextController.text != '') {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: ctx.state.accountTextController.text,
          password: ctx.state.passWordTextController.text);
    } on Exception catch (e) {
      Toast.show(e.toString(), ctx.context, duration: 3, gravity: Toast.BOTTOM);
      ctx.state.submitAnimationController.reverse();
    }
  }
  return null;
}

Future<AuthResult> _phoneNumSignIn(
    Action action, Context<LoginPageState> ctx) async {
  if (_verificationId != null && ctx.state.codeTextContraller.text.isNotEmpty) {
    try {
      final _credential = PhoneAuthProvider.getCredential(
          verificationId: _verificationId,
          smsCode: ctx.state.codeTextContraller.text);
      return await _auth.signInWithCredential(_credential);
    } on Exception catch (e) {
      Toast.show(e.toString(), ctx.context, duration: 3, gravity: Toast.BOTTOM);
      ctx.state.submitAnimationController.reverse();
    }
  }

  return null;
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

String _verificationId;
void _onSendVerificationCode(Action action, Context<LoginPageState> ctx) async {
  if (ctx.state.phoneTextController.text.isEmpty ||
      ctx.state.phoneTextController.text.length < 8)
    return Toast.show('Invalid phone number', ctx.context);
  _auth.verifyPhoneNumber(
      phoneNumber: ctx.state.countryCode + ctx.state.phoneTextController.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: null,
      verificationFailed: (AuthException e) {
        print('error code: ${e.code}, message: ${e.message}');
        Toast.show(e.message, ctx.context,
            gravity: Toast.TOP, duration: Toast.LENGTH_LONG);
      },
      codeSent: (String verificationId, [int]) {
        _verificationId = verificationId;
        print(verificationId);
      },
      codeAutoRetrievalTimeout: null);
}
