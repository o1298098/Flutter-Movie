import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PopularComponent extends Component<PopularState> {
  PopularComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PopularState>(
                adapter: null,
                slots: <String, Dependent<PopularState>>{
                }),);

}
