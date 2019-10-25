import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TestPageState> buildEffect() {
  return combineEffects(<Object, Effect<TestPageState>>{
    TestPageAction.action: _onAction,
    TestPageAction.googleSignIn: _onGoogleSingeIn,
    TestPageAction.inputTapped: _inputTapped,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<TestPageState> ctx) {}
void _onInit(Action action, Context<TestPageState> ctx) {
  final s = Firestore.instance
      .collection("SteamLinks")
      //.where('name', isEqualTo: 'kk')
      .snapshots();
  ctx.dispatch(TestPageActionCreator.setData(s));
}

void _inputTapped(Action action, Context<TestPageState> ctx) {
  Firestore.instance.collection("SteamLinks").add({'name': 'li', 'value': 12});
}

void _onGoogleSingeIn(Action action, Context<TestPageState> ctx) async {
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
}
