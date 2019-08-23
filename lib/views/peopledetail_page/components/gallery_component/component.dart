import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GalleryComponent extends Component<GalleryState> {
  GalleryComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GalleryState>(
                adapter: null,
                slots: <String, Dependent<GalleryState>>{
                }),);

}
