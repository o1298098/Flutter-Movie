import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class ShimmerCellComponent extends Component<ShimmerCellState> {
  ShimmerCellComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<ShimmerCellState>(
                adapter: null,
                slots: <String, Dependent<ShimmerCellState>>{
                }),);

}
