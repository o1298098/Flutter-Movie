import 'package:fish_redux/fish_redux.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FavoritesPage extends Page<FavoritesPageState, Map<String, dynamic>> {
  @override
  CustomstfState<FavoritesPageState> createState()=>CustomstfState<FavoritesPageState> ();
  FavoritesPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FavoritesPageState>(
                adapter: null,
                slots: <String, Dependent<FavoritesPageState>>{
                }),
            middleware: <Middleware<FavoritesPageState>>[
            ],);

}
