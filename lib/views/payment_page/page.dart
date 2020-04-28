import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PaymentPage extends Page<PaymentPageState, Map<String, dynamic>> {
  PaymentPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PaymentPageState>(
              adapter: null, slots: <String, Dependent<PaymentPageState>>{}),
          middleware: <Middleware<PaymentPageState>>[],
        );
}
