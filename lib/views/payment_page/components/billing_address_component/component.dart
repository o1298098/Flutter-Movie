import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class BillingAddressComponent extends Component<BillingAddressState> {
  BillingAddressComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<BillingAddressState>(
              adapter: null, slots: <String, Dependent<BillingAddressState>>{}),
        );
}
