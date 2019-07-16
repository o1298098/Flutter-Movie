import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';
class CreditsComponent extends Component<CreditsState> {
  CreditsComponent()
      : super(
            effect: buildEffect(),
            view: buildView,
            dependencies: Dependencies<CreditsState>(
                adapter: null,
                slots: <String, Dependent<CreditsState>>{
                }),);

}
