import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';

class CastListDetailState implements Cloneable<CastListDetailState> {
  BaseCastList castList;
  CastListDetail listDetail;
  @override
  CastListDetailState clone() {
    return CastListDetailState()
      ..castList = castList
      ..listDetail = listDetail;
  }
}

CastListDetailState initState(Map<String, dynamic> args) {
  CastListDetailState state = CastListDetailState();
  state.castList = args['castList'];
  return state;
}
