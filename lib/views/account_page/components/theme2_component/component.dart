import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class Theme2Component extends Component<Theme2State> {
  Theme2Component()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<Theme2State>(
                adapter: null,
                slots: <String, Dependent<Theme2State>>{
                }),);

}
