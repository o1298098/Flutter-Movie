import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/combinedcredits.dart';

class TimeLineState implements Cloneable<TimeLineState> {
String department;
CombinedCreditsModel creditsModel;
bool showmovie=true;

TimeLineState({this.department,this.creditsModel,this.showmovie});

  @override
  TimeLineState clone() {
    return TimeLineState()
    ..creditsModel=creditsModel
    ..department=department
    ..showmovie=showmovie;
  }
}

TimeLineState initState(Map<String, dynamic> args) {
  return TimeLineState();
}
