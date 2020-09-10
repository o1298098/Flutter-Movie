import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/people_detail.dart';
import 'package:movie/views/peopledetail_page/state.dart';

class PersonalInfoState implements Cloneable<PersonalInfoState> {
  PeopleDetailModel peopleDetailModel;
  int creditcount;

  PersonalInfoState({this.peopleDetailModel, this.creditcount});

  @override
  PersonalInfoState clone() {
    return PersonalInfoState()
      ..peopleDetailModel = peopleDetailModel
      ..creditcount = creditcount;
  }
}

class PersonalInfoConnector
    extends ConnOp<PeopleDetailPageState, PersonalInfoState> {
  @override
  PersonalInfoState get(PeopleDetailPageState state) {
    PersonalInfoState mstate = PersonalInfoState();
    mstate.peopleDetailModel = state.peopleDetailModel;
    mstate.creditcount =
        state.creditsModel.cast.length + state.creditsModel.crew.length;
    return mstate;
  }
}
