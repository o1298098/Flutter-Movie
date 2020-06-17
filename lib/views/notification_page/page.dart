import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NotificationPage extends Page<NotificationState, Map<String, dynamic>> {
  NotificationPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NotificationState>(
                adapter: null,
                slots: <String, Dependent<NotificationState>>{
                }),
            middleware: <Middleware<NotificationState>>[
            ],);

}
