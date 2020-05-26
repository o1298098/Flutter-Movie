import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class ApplePayComponent extends Component<ApplePayState> {
  ApplePayComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<ApplePayState>(
                adapter: null,
                slots: <String, Dependent<ApplePayState>>{
                }),);

}
