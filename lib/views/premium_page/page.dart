import 'package:fish_redux/fish_redux.dart';

import 'components/plan_component/component.dart';
import 'components/plan_component/state.dart';
import 'components/premium_info_component/component.dart';
import 'components/premium_info_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PremiumPage extends Page<PremiumPageState, Map<String, dynamic>> {
  PremiumPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PremiumPageState>(
              adapter: null,
              slots: <String, Dependent<PremiumPageState>>{
                'plan': PlanConnector() + PlanComponent(),
                'info': PremiumInfoConnector() + PremiumInfoComponent(),
              }),
          middleware: <Middleware<PremiumPageState>>[],
        );
}
