import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/coming_page/components/tv_component/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TVListComponent extends Component<TVListState> {
  TVListComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.page != newState.page;
          },
          clearOnDependenciesChanged: true,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TVListState>(
              adapter: NoneConn<TVListState>() + TVlistAdapter(),
              slots: <String, Dependent<TVListState>>{}),
        );
}
