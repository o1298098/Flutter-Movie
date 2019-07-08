import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/tvdetail_page/components/featuredcrew_component/component.dart';

import 'components/currentseason_component/component.dart';
import 'components/currentseason_component/state.dart';
import 'components/featuredcrew_component/state.dart';
import 'components/keywords_component/component.dart';
import 'components/keywords_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TVDetailPage extends Page<TVDetailPageState, Map<String, dynamic>> {
  TVDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TVDetailPageState>(
                adapter: null,
                slots: <String, Dependent<TVDetailPageState>>{
                  'keywords':KeyWordsComponent().asDependent(KeyWordsConnector()),
                  'featuredCrew':FeatureCrewComponent().asDependent(FeatureCrewConnector()),
                  'currentSeason':CurrentSeasonComponent().asDependent(CurrentSeasonConnector()),
                }),
            middleware: <Middleware<TVDetailPageState>>[
            ],);

}
