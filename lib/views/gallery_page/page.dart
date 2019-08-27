import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GalleryPage extends Page<GalleryPageState, Map<String, dynamic>> with SingleTickerProviderMixin{
  GalleryPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GalleryPageState>(
              adapter: null, slots: <String, Dependent<GalleryPageState>>{}),
          middleware: <Middleware<GalleryPageState>>[],
        );
}
