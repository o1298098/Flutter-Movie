import 'package:fish_redux/fish_redux.dart';

import 'cast_component/component.dart';
import 'cast_component/state.dart';
import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          view: buildView,
          shouldUpdate: (o, n) {
            return o.name != n.name ||
                o.overview != n.overview ||
                o.detail != n.detail;
          },
          clearOnDependenciesChanged: true,
          dependencies: Dependencies<HeaderState>(
              adapter: null,
              slots: <String, Dependent<HeaderState>>{
                'cast': CastConnector() + CastComponent()
              }),
        );
}
