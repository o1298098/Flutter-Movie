import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class CastComponent extends Component<CastState> {
  CastComponent()
      : super(
          view: buildView,
          clearOnDependenciesChanged: true,
          shouldUpdate: (o, n) {
            return o.casts != n.casts;
          },
          dependencies: Dependencies<CastState>(
              adapter: null, slots: <String, Dependent<CastState>>{}),
        );
}
