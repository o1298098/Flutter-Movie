import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class CreateCardPage extends Page<CreateCardState, Map<String, dynamic>> {
  CreateCardPage()
      : super(
            initState: initState,
            view: buildView,
            dependencies: Dependencies<CreateCardState>(
                adapter: null,
                slots: <String, Dependent<CreateCardState>>{
                }),
            middleware: <Middleware<CreateCardState>>[
            ],);

}
