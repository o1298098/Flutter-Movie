import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PaymentComponent extends Component<PaymentState> {
  PaymentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PaymentState>(
                adapter: null,
                slots: <String, Dependent<PaymentState>>{
                }),);

}
