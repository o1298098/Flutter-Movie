import 'package:fish_redux/fish_redux.dart';
import 'components/body_component/component.dart';
import 'components/body_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountPage extends Page<AccountPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  AccountPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AccountPageState>(
              adapter: null,
              slots: <String, Dependent<AccountPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'body': BodyConnector() + BodyComponent(),
              }),
          middleware: <Middleware<AccountPageState>>[],
        );
}
