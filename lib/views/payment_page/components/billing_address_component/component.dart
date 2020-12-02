import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/payment_page/components/billing_address_component/create_address_component/component.dart';
import 'package:movie/views/payment_page/components/billing_address_component/create_address_component/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BillingAddressComponent extends Component<BillingAddressState> {
  BillingAddressComponent()
      : super(
          view: buildView,
          shouldUpdate: (oldState, newState) {
            return oldState.address != newState.address ||
                oldState.createAddressState != newState.createAddressState;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          dependencies: Dependencies<BillingAddressState>(
              adapter: null,
              slots: <String, Dependent<BillingAddressState>>{
                'createAddress':
                    CreateAddressConnector() + CreateAddressComponent()
              }),
        );
}
