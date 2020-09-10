import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/base_api_model/user_list_detail.dart';
import 'package:movie/views/listdetail_page/components/listcell_component/state.dart';
import 'package:movie/views/listdetail_page/state.dart';

class BodyState extends MutableSource implements Cloneable<BodyState> {
  UserListDetailModel listItems;
  @override
  BodyState clone() {
    return BodyState()..listItems = listItems;
  }

  @override
  Object getItemData(int index) =>
      ListCellState(cellData: listItems.data[index]);

  @override
  String getItemType(int index) => 'listCell';

  @override
  int get itemCount => listItems?.data?.length ?? 0;

  @override
  void setItemData(int index, Object data) {}
}

class BodyConnector extends ConnOp<ListDetailPageState, BodyState> {
  @override
  BodyState get(ListDetailPageState state) {
    BodyState mstate = BodyState();
    mstate.listItems = state.listItems;
    return mstate;
  }

  @override
  void set(ListDetailPageState state, BodyState subState) {}
}
