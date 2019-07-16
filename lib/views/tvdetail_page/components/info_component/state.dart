import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/tvdetail.dart';
import 'package:movie/views/tvdetail_page/state.dart';

class InfoState implements Cloneable<InfoState> {

 TVDetailModel tvDetailModel;

  @override
  InfoState clone() {
    return InfoState();
  }
}
class InfoConnector extends ConnOp<TVDetailPageState,InfoState>{
  @override
  InfoState get(TVDetailPageState state) {
    InfoState substate=new InfoState();
    substate.tvDetailModel=state.tvDetailModel;
    return substate;
  }
}
