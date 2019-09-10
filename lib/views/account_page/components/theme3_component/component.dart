import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class Theme3Component extends Component<Theme3State> {
  Theme3Component()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<Theme3State>(
                adapter: null,
                slots: <String, Dependent<Theme3State>>{
                }),);

}
