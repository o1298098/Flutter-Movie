import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PersonalInfoComponent extends Component<PersonalInfoState> {
  PersonalInfoComponent()
      : super(
          shouldUpdate: (olditem, newitem) {
            return newitem.peopleDetailModel != olditem.peopleDetailModel;
          },
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PersonalInfoState>(
              adapter: null, slots: <String, Dependent<PersonalInfoState>>{}),
        );
}
