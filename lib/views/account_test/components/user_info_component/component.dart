import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UserInfoComponent extends Component<UserInfoState> {
  UserInfoComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<UserInfoState>(
                adapter: null,
                slots: <String, Dependent<UserInfoState>>{
                }),);

}
