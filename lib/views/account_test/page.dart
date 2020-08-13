import 'package:fish_redux/fish_redux.dart';

import 'components/settings_component/component.dart';
import 'components/settings_component/state.dart';
import 'components/user_info_component/component.dart';
import 'components/user_info_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountPage extends Page<AccountState, Map<String, dynamic>> {
  AccountPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountState>(
              adapter: null,
              slots: <String, Dependent<AccountState>>{
                'userInfo': UserInfoConnector() + UserInfoComponent(),
                'settings': SettingsConnector() + SettingsComponent()
              }),
          middleware: <Middleware<AccountState>>[],
        );
}
