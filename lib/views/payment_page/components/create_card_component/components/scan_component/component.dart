import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ScanComponent extends Component<ScanState> {
  ScanComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ScanState>(
              adapter: null, slots: <String, Dependent<ScanState>>{}),
        );
}
