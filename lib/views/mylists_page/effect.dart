import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'action.dart';
import 'state.dart';

Effect<MyListsPageState> buildEffect() {
  return combineEffects(<Object, Effect<MyListsPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.deactivate: _onDeactivate,
    Lifecycle.dispose: _onDispose,
    MyListsPageAction.action: _onAction,
    MyListsPageAction.createList: _createList,
    MyListsPageAction.cellTapped: _cellTapped,
    MyListsPageAction.deleteList: _deleteList,
  });
}

void _onAction(Action action, Context<MyListsPageState> ctx) {}

Future _onInit(Action action, Context<MyListsPageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.cellAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.scrollController = ScrollController(keepScrollOffset: false);
  if (ctx.state.user != null) {
    final data = Firestore.instance
        .collection('MyList')
        .document(ctx.state.user.uid)
        .collection('List')
        .orderBy('updateDateTime', descending: true)
        .snapshots();
    ctx.dispatch(MyListsPageActionCreator.setList(data));
  }
}

void _onDispose(Action action, Context<MyListsPageState> ctx) {
  ctx.state.cellAnimationController.stop();
  ctx.state.scrollController.dispose();
  ctx.state.animationController.dispose();
  ctx.state.cellAnimationController.dispose();
}

void _onDeactivate(Action action, Context<MyListsPageState> ctx) {
  ctx.state.cellAnimationController.stop();
  ctx.state.animationController.stop();
}

Future _cellTapped(Action action, Context<MyListsPageState> ctx) async {
  await Navigator.of(ctx.context)
      .pushNamed('ListDetailPage', arguments: {'list': action.payload});
}

void _createList(Action action, Context<MyListsPageState> ctx) async {
  ctx.state.animationController.value = 0;
  ctx.dispatch(MyListsPageActionCreator.onEdit(false));
  await Navigator.of(ctx.context)
      .pushNamed('createListPage', arguments: action.payload);
}

void _deleteList(Action action, Context<MyListsPageState> ctx) {
  DocumentSnapshot d = action.payload;
  if (d != null) {
    showDialog<void>(
      context: ctx.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                d.reference.delete();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
