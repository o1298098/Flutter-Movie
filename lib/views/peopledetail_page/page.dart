import 'package:fish_redux/fish_redux.dart';

import 'adapter/adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PeopleDetailPage extends Page<PeopleDetailPageState, Map<String, dynamic>> {
  PeopleDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PeopleDetailPageState>(
                adapter:NoneConn<PeopleDetailPageState>()+ PeopleAdapter(),
                slots: <String, Dependent<PeopleDetailPageState>>{
                }),
            middleware: <Middleware<PeopleDetailPageState>>[
            ],);

}
