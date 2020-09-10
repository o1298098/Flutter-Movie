import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class AndroidPayComponent extends Component<AndroidPayState> {
  AndroidPayComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<AndroidPayState>(
                adapter: null,
                slots: <String, Dependent<AndroidPayState>>{
                }),);

}
