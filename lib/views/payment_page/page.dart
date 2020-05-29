import 'package:fish_redux/fish_redux.dart';

import 'components/billing_address_component/component.dart';
import 'components/billing_address_component/state.dart';
import 'components/create_card_component/component.dart';
import 'components/create_card_component/state.dart';
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
                'createCard': CreateCardConnector() + CreateCardComponent(),
                'history': HistoryConnector() + HistoryComponent(),
                'billingAddress':
                    BillingAddressConnector() + BillingAddressComponent()
              }),
          middleware: <Middleware<PaymentPageState>>[],
        );
}
