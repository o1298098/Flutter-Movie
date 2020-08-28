import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StreamLinkFilterComponent extends Component<StreamLinkFilterState> {
  StreamLinkFilterComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<StreamLinkFilterState>(
                adapter: null,
                slots: <String, Dependent<StreamLinkFilterState>>{
                }),);

}
