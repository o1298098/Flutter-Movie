import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/views/mylists_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<ListCellState> buildEffect() {
  return combineEffects(<Object, Effect<ListCellState>>{
    ListCellAction.action: _onAction,
    ListCellAction.cellTapped: _cellTapped,
    ListCellAction.deleteList: _deleteList,
    ListCellAction.onEdit: _onEdit,
  });
}

void _onAction(Action action, Context<ListCellState> ctx) {}

Future _cellTapped(Action action, Context<ListCellState> ctx) async {
  await Navigator.of(ctx.context)
      .pushNamed('ListDetailPage', arguments: {'list': action.payload});
}

void _deleteList(Action action, Context<ListCellState> ctx) {
  final UserList d = action.payload;
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
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                final _baseApi = BaseApi.instance;
                _baseApi.deleteUserList(d.id).then((d) {});
                ctx.dispatch(ListCellActionCreator.onDeleteList(d));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _onEdit(Action action, Context<ListCellState> ctx) async {
  ctx.state.animationController.value = 0;
  ctx.state.cellAnimationController.reset();
  ctx.dispatch(MyListsPageActionCreator.onEdit(false));
  await Navigator.of(ctx.context)
      .pushNamed('createListPage', arguments: action.payload);
}
