import 'package:fish_redux/fish_redux.dart';

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
                }),
            middleware: <Middleware<AccountState>>[
            ],);

}
