import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class FeatureCrewState implements Cloneable<FeatureCrewState> {
 
List<CreatedBy> createdBy;

  @override
  FeatureCrewState clone() {
    return FeatureCrewState();
  }
}

class FeatureCrewConnector extends ConnOp<TVDetailPageState,FeatureCrewState>{
  @override
  FeatureCrewState get(TVDetailPageState state) {
    FeatureCrewState substate=new FeatureCrewState();
    substate.createdBy=state.tvDetailModel.createdBy??List<CreatedBy>();
    return substate;
  }
}
