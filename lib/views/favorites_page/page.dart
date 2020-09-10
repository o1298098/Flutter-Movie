import 'package:fish_redux/fish_redux.dart';
import 'components/background_component/component.dart';
import 'components/background_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/swiper_component/component.dart';
import 'components/swiper_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FavoritesPage extends Page<FavoritesPageState, Map<String, dynamic>>
    with TickerProviderMixin {
  FavoritesPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FavoritesPageState>(
              adapter: null,
              slots: <String, Dependent<FavoritesPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'swiper': SwiperConnector() + SwiperComponent(),
                'backGround': BackGroundConnector() + BackGroundComponent()
              }),
          middleware: <Middleware<FavoritesPageState>>[],
        );
}
