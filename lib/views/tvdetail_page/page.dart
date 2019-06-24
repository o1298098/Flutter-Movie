import 'package:fish_redux/fish_redux.dart';

import 'compontents/keywords_component/component.dart';
import 'compontents/keywords_component/state.dart';
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
                }),
            middleware: <Middleware<TVDetailPageState>>[
            ],);

}
