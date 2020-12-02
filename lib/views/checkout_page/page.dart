import 'package:fish_redux/fish_redux.dart';

import 'components/payment_component/component.dart';
import 'components/payment_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CheckOutPage extends Page<CheckOutPageState, Map<String, dynamic>> {
  CheckOutPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CheckOutPageState>(
              adapter: null,
              slots: <String, Dependent<CheckOutPageState>>{
                'payment': PaymentConnector() + PaymentComponent()
              }),
          middleware: <Middleware<CheckOutPageState>>[],
        );
}
