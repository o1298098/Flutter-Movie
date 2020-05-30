import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CreateCardComponent extends Component<CreateCardState>
    with TickerProviderMixin {
  CreateCardComponent()
      : super(
          view: buildView,
          effect: buildEffect(),
          reducer: buildReducer(),
          dependencies: Dependencies<CreateCardState>(
              adapter: null, slots: <String, Dependent<CreateCardState>>{}),
        );
}
