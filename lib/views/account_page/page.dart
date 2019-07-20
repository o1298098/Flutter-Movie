import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AccountPage extends Page<AccountPageState, Map<String, dynamic>> {
@override
  CustomstfState<AccountPageState> createState()=>CustomstfState<AccountPageState> ();

  AccountPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AccountPageState>(
                adapter: null,
                slots: <String, Dependent<AccountPageState>>{
                }),
            middleware: <Middleware<AccountPageState>>[
            ],);

}
