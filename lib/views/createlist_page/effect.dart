import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/http/base_api.dart';
import 'package:movie/models/base_api_model/user_list.dart';
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
      BaseApi.updateUserList(ctx.state.listData
        ..backGroundUrl = ctx.state.backGroundTextController.text
        ..description = ctx.state.descriptionTextController.text);
    else {
      final _date = DateTime.now().toString();
      ctx.state.listData = UserList.fromParams(
        uid: ctx.state.user.firebaseUser.uid,
        listName: ctx.state.nameTextController.text,
        backGroundUrl: ctx.state.backGroundTextController.text,
        description: ctx.state.descriptionTextController.text,
        createTime: _date,
        updateTime: _date,
        revenue: 0,
        runTime: 0,
        itemCount: 0,
        totalRated: 0,
      );
      BaseApi.createUserList(ctx.state.listData);
    }

    Navigator.of(ctx.context).pop(ctx.state.listData);
  }
}
