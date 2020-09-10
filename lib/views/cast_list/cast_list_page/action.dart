import 'package:fish_redux/fish_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';

enum CastListAction {
  action,
  addCastList,
  setCastList,
  onCastListTap,
  onCastListEdit
}

class CastListActionCreator {
  static Action onAction() {
    return const Action(CastListAction.action);
  }

  static Action addCastList() {
    return const Action(CastListAction.addCastList);
  }

  static Action setCastList(Stream<FetchResult> stream) {
    return Action(CastListAction.setCastList, payload: stream);
  }

  static Action onCastListTap(BaseCastList list) {
    return Action(CastListAction.onCastListTap, payload: list);
  }

  static Action onCastListEdit(BaseCastList list) {
    return Action(CastListAction.onCastListEdit, payload: list);
  }
}
