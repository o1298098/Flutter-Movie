import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HeaderComponent extends Component<HeaderState> {
  HeaderComponent()
      : super(
          shouldUpdate: (olditem, newitem) {
            return newitem.biography != olditem.biography ||
                newitem.birthday != olditem.birthday ||
                newitem.character != olditem.character ||
                newitem.deathday != newitem.deathday ||
                newitem.peopleid != olditem.peopleid ||
                newitem.profileName != olditem.profileName ||
                newitem.profilePath != olditem.profilePath;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HeaderState>(
              adapter: null, slots: <String, Dependent<HeaderState>>{}),
        );
}
