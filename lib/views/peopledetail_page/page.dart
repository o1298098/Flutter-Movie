import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PeopleDetailPagePage extends Page<PeopleDetailPageState, Map<String, dynamic>> {
  PeopleDetailPagePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PeopleDetailPageState>(
                adapter: null,
                slots: <String, Dependent<PeopleDetailPageState>>{
                }),
            middleware: <Middleware<PeopleDetailPageState>>[
            ],);

}
