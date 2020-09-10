import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ImagesComponent extends Component<ImagesState> {
  ImagesComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.images != newState.images;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ImagesState>(
              adapter: null, slots: <String, Dependent<ImagesState>>{}),
        );
}
