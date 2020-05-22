import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PlanComponent extends Component<PlanState> {
  PlanComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PlanState>(
                adapter: null,
                slots: <String, Dependent<PlanState>>{
                }),);

}
