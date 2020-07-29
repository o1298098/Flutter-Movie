import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TimeLineComponent extends Component<TimeLineState> {
  TimeLineComponent()
      : super(
          shouldUpdate: (olditem, newitem) {
            return newitem.movies != olditem.movies ||
                newitem.department != olditem.department ||
                olditem.showmovie != newitem.showmovie ||
                newitem.tvshows != olditem.tvshows;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TimeLineState>(
              adapter: null, slots: <String, Dependent<TimeLineState>>{}),
        );
}
