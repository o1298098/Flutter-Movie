import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class InfoComponent extends Component<InfoState> {
  InfoComponent()
      : super(
            view: buildView,
            effect: buildEffect(),
            dependencies: Dependencies<InfoState>(
                adapter: null,
                slots: <String, Dependent<InfoState>>{
                }),);

}
