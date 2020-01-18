import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FilterComponent extends Component<FilterState> {
  FilterComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FilterState>(
              adapter: null, slots: <String, Dependent<FilterState>>{}),
        );
}
