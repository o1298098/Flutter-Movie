import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HistoryComponent extends Component<HistoryState> {
  HistoryComponent()
      : super(
          view: buildView,
          effect: buildEffect(),
          reducer: buildReducer(),
          dependencies: Dependencies<HistoryState>(
              adapter: null, slots: <String, Dependent<HistoryState>>{}),
        );
}
