import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/enums/streamlink_type.dart';
import 'action.dart';
import 'state.dart';

Effect<AddLinkPageState> buildEffect() {
  return combineEffects(<Object, Effect<AddLinkPageState>>{
    AddLinkPageAction.action: _onAction,
    AddLinkPageAction.submit: _onSubmit,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<AddLinkPageState> ctx) {}

void _onSubmit(Action action, Context<AddLinkPageState> ctx) {
  if (ctx.state.user != null) {
    final String mtype = ctx.state.type == MediaType.movie ? 'Movie' : 'TV';
    final String streamType = ctx.state.streamLinkType == StreamLinkType.youtube
        ? 'YouTube'
        : 'other';
    final DocumentReference d = Firestore.instance
        .collection('StreamLinks')
        .document('$mtype${ctx.state.id}');

    if (ctx.state.linkData == null) {
      d.setData({
        'id': ctx.state.id,
        'type': mtype,
        'name': ctx.state.name,
        'photourl': ctx.state.photoUrl,
        'updateTime': DateTime.now()
      });
      Firestore.instance
          .collection('AccountState')
          .document(ctx.state.user.uid)
          .collection('MyStreamLink')
          .document('$mtype${ctx.state.id}')
          .setData({
        'id': ctx.state.id,
        'type': mtype,
        'name': ctx.state.name,
        'photourl': ctx.state.photoUrl
      });
      d.collection('Link').document(ctx.state.user.uid).setData({
        'linkName': ctx.state.linkName,
        'streamLink': ctx.state.streamLink,
        'streamLinkType': streamType,
        'createTime': DateTime.now(),
        'updateTime': DateTime.now()
      });
    } else {
      d.updateData({'updateTime': DateTime.now()});
      d.collection('Link').document(ctx.state.user.uid).updateData({
        'linkName': ctx.state.linkName,
        'streamLink': ctx.state.streamLink,
        'streamLinkType': streamType,
        'updateTime': DateTime.now()
      });
    }
    Navigator.of(ctx.context).pop();
  }
}

Future _onInit(Action action, Context<AddLinkPageState> ctx) async {
  final String mtype = ctx.state.type == MediaType.movie ? 'Movie' : 'TV';
  Firestore.instance
      .collection('StreamLinks')
      .document('$mtype${ctx.state.id}')
      .collection('Link')
      .document(ctx.state.user.uid)
      .get()
      .then((d) {
    if (d.exists) ctx.dispatch(AddLinkPageActionCreator.setLinkData(d));
    ctx.state.linkNameTextController =
        TextEditingController(text: ctx.state.linkName);
    ctx.state.streamLinkTextController =
        TextEditingController(text: ctx.state.streamLink);
  });
}
