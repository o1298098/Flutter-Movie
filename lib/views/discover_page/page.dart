import 'package:fish_redux/fish_redux.dart';

import 'adapter.dart';
import 'components/filter_component/component.dart';
import 'components/filter_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscoverPage extends Page<DiscoverPageState, Map<String, dynamic>> {
  DiscoverPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          shouldUpdate: (o, n) {
            return o.filterState.isMovie != n.filterState.isMovie ||
                o.videoListModel != n.videoListModel ||
                o.isbusy != n.isbusy;
          },
          view: buildView,
          dependencies: Dependencies<DiscoverPageState>(
              adapter: NoneConn<DiscoverPageState>() + DiscoverListAdapter(),
              slots: <String, Dependent<DiscoverPageState>>{
                'filter': FilterConnector() + FilterComponent()
              }),
          middleware: <Middleware<DiscoverPageState>>[],
        );
}
