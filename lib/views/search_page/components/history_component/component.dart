import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HistoryComponent extends Component<HistoryState> {
  HistoryComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HistoryState>(
                adapter: null,
                slots: <String, Dependent<HistoryState>>{
                }),);

}
