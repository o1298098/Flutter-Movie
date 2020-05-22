import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PremiumInfoComponent extends Component<PremiumInfoState> {
  PremiumInfoComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PremiumInfoState>(
                adapter: null,
                slots: <String, Dependent<PremiumInfoState>>{
                }),);

}
