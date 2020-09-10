import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';

class ImagesComponent extends Component<ImagesState> {
  ImagesComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.backdrops != newState.backdrops ||
                oldState.posters != newState.posters;
          },
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<ImagesState>(
              adapter: null, slots: <String, Dependent<ImagesState>>{}),
        );
}
