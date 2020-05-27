import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CreateAddressComponent extends Component<CreateAddressState> {
  CreateAddressComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CreateAddressState>(
                adapter: null,
                slots: <String, Dependent<CreateAddressState>>{
                }),);

}
