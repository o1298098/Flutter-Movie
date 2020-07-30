import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';

enum CastListDetailAction { action, setListDetail }

class CastListDetailActionCreator {
  static Action onAction() {
    return const Action(CastListDetailAction.action);
  }

  static Action setListDetail(CastListDetail detail) {
    return Action(CastListDetailAction.setListDetail, payload: detail);
  }
}
