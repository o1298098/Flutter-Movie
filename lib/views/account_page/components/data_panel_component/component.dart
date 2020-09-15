import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DataPanelComponent extends Component<DataPanelState> {
  DataPanelComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DataPanelState>(
                adapter: null,
                slots: <String, Dependent<DataPanelState>>{
                }),);

}
