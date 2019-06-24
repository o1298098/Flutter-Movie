import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MovieCellComponent extends Component<VideoCellState> {
  MovieCellComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<VideoCellState>(
                adapter: null,
                slots: <String, Dependent<VideoCellState>>{
                }),);

}
