import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TVCellsComponent extends Component<TVCellsState> {
  TVCellsComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TVCellsState>(
                adapter: null,
                slots: <String, Dependent<TVCellsState>>{
                }),);

}
