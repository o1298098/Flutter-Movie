import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class KeyWordsComponent extends Component<KeyWordsState> {
  KeyWordsComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<KeyWordsState>(
                adapter: null,
                slots: <String, Dependent<KeyWordsState>>{
                }),);

}
