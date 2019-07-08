import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
            view: buildView,
            dependencies: Dependencies<HeaderState>(
                adapter: null,
                slots: <String, Dependent<HeaderState>>{
                }),);

}
