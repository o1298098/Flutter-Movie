import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlayerComponent extends Component<PlayerState> {
  PlayerComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PlayerState>(
                adapter: null,
                slots: <String, Dependent<PlayerState>>{
                }),);

}
