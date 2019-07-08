import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class FeatureCrewComponent extends Component<FeatureCrewState> {
  FeatureCrewComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<FeatureCrewState>(
                adapter: null,
                slots: <String, Dependent<FeatureCrewState>>{
                }),);

}
