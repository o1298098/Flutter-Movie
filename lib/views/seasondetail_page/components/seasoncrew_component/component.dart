import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonCrewComponent extends Component<SeasonCrewState> {
  SeasonCrewComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SeasonCrewState>(
                adapter: null,
                slots: <String, Dependent<SeasonCrewState>>{
                }),);

}
