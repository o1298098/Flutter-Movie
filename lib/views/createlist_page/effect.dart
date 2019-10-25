import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<CreateListPageState> buildEffect() {
  return combineEffects(<Object, Effect<CreateListPageState>>{
    CreateListPageAction.action: _onAction,
    CreateListPageAction.submit: _submit,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<CreateListPageState> ctx) {}
void _onInit(Action action, Context<CreateListPageState> ctx) {
  ctx.state.backGroundTextController =
      TextEditingController(text: ctx.state.backGroundUrl);
  ctx.state.nameTextController = TextEditingController(text: ctx.state.name);
  ctx.state.descriptionTextController =
      TextEditingController(text: ctx.state.description);
}

void _submit(Action action, Context<CreateListPageState> ctx) {
  if (ctx.state.user != null) {
    if (ctx.state.listData != null)
      ctx.state.listData.reference.updateData({
        'description': ctx.state.description,
        'backGroundUrl': ctx.state.backGroundUrl,
        'updateDateTime': DateTime.now(),
      });
    else
      Firestore.instance
          .collection("MyList")
          .document(ctx.state.user.uid)
          .collection('List')
          .document(ctx.state.name)
          .setData({
        'description': ctx.state.description,
        'backGroundUrl': ctx.state.backGroundUrl,
        'selected': false,
        'createDateTime': DateTime.now(),
        'updateDateTime': DateTime.now(),
        'itemCount': 0,
        'totalRated': 0.0,
        'runTime': 0,
        'revenue': 0
      });
    Navigator.of(ctx.context).pop();
  }
}
