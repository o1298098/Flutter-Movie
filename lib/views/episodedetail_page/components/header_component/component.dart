import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EpisodeHeaderComponent extends Component<EpisodeHeaderState> {
  EpisodeHeaderComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<EpisodeHeaderState>(
                adapter: null,
                slots: <String, Dependent<EpisodeHeaderState>>{
                }),);

}
