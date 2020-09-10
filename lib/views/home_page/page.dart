import 'package:fish_redux/fish_redux.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/popularposter_cpmponent/component.dart';
import 'components/popularposter_cpmponent/state.dart';
import 'components/share_component/component.dart';
import 'components/share_component/state.dart';
import 'components/swiper_component/component.dart';
import 'components/swiper_component/state.dart';
import 'components/trending_component/component.dart';
import 'components/trending_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomePage extends Page<HomePageState, Map<String, dynamic>>
    with TickerProviderMixin {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          shouldUpdate: (o, n) {
            return false;
          },
          dependencies: Dependencies<HomePageState>(
              adapter: null,
              slots: <String, Dependent<HomePageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'swiper': SwiperConnector() + SwiperComponent(),
                'trending': TrendingConnector() + TrendingComponent(),
                'share': ShareConnector() + ShareComponent(),
                'popularposter':
                    PopularPosterConnector() + PopularPosterComponent()
              }),
          middleware: <Middleware<HomePageState>>[],
        );
}
