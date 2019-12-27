import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MoreMediaPage extends Page<MoreMediaPageState, Map<String, dynamic>> {
  @override
  CustomstfState<MoreMediaPageState> createState() =>
      CustomstfState<MoreMediaPageState>();
  MoreMediaPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MoreMediaPageState>(
              adapter: null, slots: <String, Dependent<MoreMediaPageState>>{}),
          middleware: <Middleware<MoreMediaPageState>>[],
        );
}
