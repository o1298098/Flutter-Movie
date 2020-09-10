import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UserDataComponent extends Component<UserDataState> {
  UserDataComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (o, n) {
            return o.user != n.user || o.info != n.info;
          },
          view: buildView,
          dependencies: Dependencies<UserDataState>(
            adapter: null,
            slots: <String, Dependent<UserDataState>>{},
          ),
        );
}
