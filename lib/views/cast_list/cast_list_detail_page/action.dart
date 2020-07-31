import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';

enum CastListDetailAction {
  action,
  setListDetail,
  onCastTap,
  setLoadMore,
  loading
}

class CastListDetailActionCreator {
  static Action onAction() {
    return const Action(CastListDetailAction.action);
  }

  static Action setListDetail(CastListDetail detail) {
    return Action(CastListDetailAction.setListDetail, payload: detail);
  }

  static Action onCastTap(BaseCast cast) {
    return Action(CastListDetailAction.onCastTap, payload: cast);
  }

  static Action setLoadMore(CastListDetail detail) {
    return Action(CastListDetailAction.setLoadMore, payload: detail);
  }

  static Action loading(bool loading) {
    return Action(CastListDetailAction.loading, payload: loading);
  }
}
