import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TimeLineComponent extends Component<TimeLineState> {
  TimeLineComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TimeLineState>(
                adapter: null,
                slots: <String, Dependent<TimeLineState>>{
                }),);

}
