import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class KnownForComponent extends Component<KnownForState> {
  KnownForComponent()
      : super(
          shouldUpdate: (olditem, newitem) {
            return newitem.cast != olditem.cast;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<KnownForState>(
              adapter: null, slots: <String, Dependent<KnownForState>>{}),
        );
}
