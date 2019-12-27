import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/coming_page/components/tv_component/shimmercell_component/component.dart';
import 'package:movie/views/coming_page/components/tv_component/tvcell_component/component.dart';

import 'state.dart';

class TVlistAdapter extends SourceFlowAdapter<TVListState> {
  TVlistAdapter()
      : super(
          pool: <String, Component<Object>>{
            'tvcell': TVCellComponent(),
            'shimmercell': ShimmerCellComponent()
          },
        );
}
