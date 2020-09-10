import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class KeywordComponent extends Component<KeywordState> {
  KeywordComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (oldState, newState) {
            return oldState.keywords != newState.keywords;
          },
          view: buildView,
          dependencies: Dependencies<KeywordState>(
              adapter: null, slots: <String, Dependent<KeywordState>>{}),
        );
}
