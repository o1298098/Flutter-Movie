import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SettingsComponent extends Component<SettingsState> {
  SettingsComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (o, n) {
            return o.adultContent != n.adultContent ||
                o.appLanguage != n.appLanguage ||
                o.enableNotifications != n.enableNotifications;
          },
          view: buildView,
          dependencies: Dependencies<SettingsState>(
              adapter: null, slots: <String, Dependent<SettingsState>>{}),
        );
}
