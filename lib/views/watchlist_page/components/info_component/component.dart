import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class InfoComponent extends Component<InfoState> {
  InfoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.selectMdeia != newState.selectMdeia;
          },
          view: buildView,
          dependencies: Dependencies<InfoState>(
              adapter: null, slots: <String, Dependent<InfoState>>{}),
        );
}
