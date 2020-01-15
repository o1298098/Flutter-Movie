import 'package:fish_redux/fish_redux.dart';

import 'components/test_component/component.dart';
import 'components/test_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TestPage extends Page<TestPageState, Map<String, dynamic>> {
  TestPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TestPageState>(
              adapter: null,
              slots: <String, Dependent<TestPageState>>{
                'test': TestConnector() + TestComponent(),
              }),
          middleware: <Middleware<TestPageState>>[],
        );
}
