import 'package:fish_redux/fish_redux.dart';

import 'adapter/adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BodyComponent extends Component<BodyState> {
  BodyComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.listItems != newState.listItems;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<BodyState>(
              adapter: NoneConn<BodyState>() + GridAdapter(),
              slots: <String, Dependent<BodyState>>{}),
        );
}
