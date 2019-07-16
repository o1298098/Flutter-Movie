import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchBarComponent extends Component<SearchBarState> {
  SearchBarComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchBarState>(
                adapter: null,
                slots: <String, Dependent<SearchBarState>>{
                }),);

}
