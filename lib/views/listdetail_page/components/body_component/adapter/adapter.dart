import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/listdetail_page/components/listcell_component/component.dart';

import '../state.dart';

class GridAdapter extends SourceFlowAdapter<BodyState> {
  GridAdapter()
      : super(
          pool: <String, Component<Object>>{'listCell': ListCellComponent()},
        );
}
