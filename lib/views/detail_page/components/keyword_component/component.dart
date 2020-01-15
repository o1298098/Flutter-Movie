import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class KeyWordComponent extends Component<KeyWordState> {
  KeyWordComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.keyWords != newState.keyWords;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<KeyWordState>(
              adapter: null, slots: <String, Dependent<KeyWordState>>{}),
        );
}
