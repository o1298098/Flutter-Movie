import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/payment_page/components/billing_address_component/component.dart';
import 'package:movie/views/payment_page/components/billing_address_component/state.dart';

import 'components/history_component/component.dart';
import 'components/history_component/state.dart';
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
              adapter: null,
              slots: <String, Dependent<PaymentPageState>>{
                'history': HistoryConnector() + HistoryComponent(),
                'billingAddress':
                    BillingAddressConnector() + BillingAddressComponent()
              }),
          middleware: <Middleware<PaymentPageState>>[],
        );
}
