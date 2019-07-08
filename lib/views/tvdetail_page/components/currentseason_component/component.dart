import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class CurrentSeasonComponent extends Component<CurrentSeasonState> {
  CurrentSeasonComponent()
      : super(
            effect: buildEffect(),
            view: buildView,
            dependencies: Dependencies<CurrentSeasonState>(
                adapter: null,
                slots: <String, Dependent<CurrentSeasonState>>{
                }),);

}
