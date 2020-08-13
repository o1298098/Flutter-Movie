import 'package:fish_redux/fish_redux.dart';

import 'adapter.dart';
import 'components/appbar_component/component.dart';
import 'components/appbar_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/tabbar_component/component.dart';
import 'components/tabbar_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SeasonLinkPage extends Page<SeasonLinkPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  SeasonLinkPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SeasonLinkPageState>(
              adapter: NoneConn<SeasonLinkPageState>() + TabViewAdapter(),
              slots: <String, Dependent<SeasonLinkPageState>>{
                'appBar': AppBarConnector() + AppBarComponent(),
                'header': HeaderConnector() + HeaderComponent(),
                'tabBar': TabbarConnector() + TabbarComponent(),
              }),
          middleware: <Middleware<SeasonLinkPageState>>[],
        );
}
