import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/views/tvdetail_page/components/featuredcrew_component/component.dart';
import 'package:movie/views/tvdetail_page/components/info_component/component.dart';
import 'package:movie/views/tvdetail_page/components/menu_component/component.dart';

import 'components/currentseason_component/component.dart';
import 'components/currentseason_component/state.dart';
import 'components/featuredcrew_component/state.dart';
import 'components/info_component/state.dart';
import 'components/keywords_component/component.dart';
import 'components/keywords_component/state.dart';
import 'components/menu_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TVDetailPage extends Page<TVDetailPageState, Map<String, dynamic>> {
  @override
  CustomstfState<TVDetailPageState> createState()=>CustomstfState<TVDetailPageState> ();
  TVDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TVDetailPageState>(
                adapter: null,
                slots: <String, Dependent<TVDetailPageState>>{
                  'keywords':KeyWordsConnector()+KeyWordsComponent(),
                  'featuredCrew':FeatureCrewConnector()+FeatureCrewComponent(),
                  'currentSeason':CurrentSeasonConnector()+CurrentSeasonComponent(),
                  'info':InfoConnector()+InfoComponent(),
                  'menu':MenuConnector()+MenuComponent()
                }),
            middleware: <Middleware<TVDetailPageState>>[
            ],);

}
