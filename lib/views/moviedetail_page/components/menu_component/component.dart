import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MenuComponent extends Component<MenuState> {
  MenuComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MenuState>(
                adapter: null,
                slots: <String, Dependent<MenuState>>{
                }),);

}
