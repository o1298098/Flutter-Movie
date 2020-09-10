import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StreamLinkFilterComponent extends Component<StreamLinkFilterState> {
  StreamLinkFilterComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          clearOnDependenciesChanged: true,
          shouldUpdate: (o, n) {
            return o.sortAsc != n.sortAsc ||
                o.sort != n.sort ||
                o.selectHost != n.selectHost ||
                o.selectLanguage != n.selectLanguage ||
                o.selectQuality != n.selectQuality ||
                o.streamLinks != n.streamLinks ||
                o.filterLinks != n.filterLinks ||
                o.selectedLink != n.selectedLink;
          },
          view: buildView,
          dependencies: Dependencies<StreamLinkFilterState>(
              adapter: null,
              slots: <String, Dependent<StreamLinkFilterState>>{}),
        );
}
