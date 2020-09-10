import 'package:fish_redux/fish_redux.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/info_component/component.dart';
import 'components/info_component/state.dart';
import 'components/swiper_component/component.dart';
import 'components/swiper_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WatchlistPage extends Page<WatchlistPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  WatchlistPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WatchlistPageState>(
              adapter: null,
              slots: <String, Dependent<WatchlistPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'swiper': SwiperConnector() + SwiperComponent(),
                'info': InfoConnector() + InfoComponent(),
              }),
          middleware: <Middleware<WatchlistPageState>>[],
        );
}
