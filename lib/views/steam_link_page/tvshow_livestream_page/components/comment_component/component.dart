import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CommentComponent extends Component<CommentState> {
  CommentComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.comments != newState.comments;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CommentState>(
              adapter: null, slots: <String, Dependent<CommentState>>{}),
        );
}
