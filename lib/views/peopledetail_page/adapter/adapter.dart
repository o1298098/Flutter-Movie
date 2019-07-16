import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/views/peopledetail_page/components/header_component/component.dart';
import 'package:movie/views/peopledetail_page/components/header_component/state.dart';
import 'package:movie/views/peopledetail_page/components/knownfor_component/component.dart';
import 'package:movie/views/peopledetail_page/components/knownfor_component/state.dart';
import 'package:movie/views/peopledetail_page/components/personalinfo_component/component.dart';
import 'package:movie/views/peopledetail_page/components/personalinfo_component/state.dart';
import 'package:movie/views/peopledetail_page/components/timeline_component/component.dart';
import 'package:movie/views/peopledetail_page/components/timeline_component/state.dart';

import '../state.dart';
import 'reducer.dart';

class PeopleAdapter extends DynamicFlowAdapter<PeopleDetailPageState> {
  PeopleAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header': HeaderComponent(),
            'knownfor': KnownForComponent(),
            'timeline': TimeLineComponent(),
            'personalinfo': PersonalInfoComponent()
          },
          connector: _PeopleConnector(),
          reducer: buildReducer(),
        );
}

class _PeopleConnector extends ConnOp<PeopleDetailPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(PeopleDetailPageState state) {
    List<ItemBean> items = <ItemBean>[];
      items.add(ItemBean(
          'header',
          HeaderState(
              peopleid: state.peopleid,
              biography: state.peopleDetailModel.biography,
              profileName: state.profileName,
              profilePath: state.profilePath,
              character: state.character)));
      var m=state.clone().creditsModel;
      m.cast=new List<CastData>()..addAll(m.cast);
      m.cast.sort((a,b)=>b.vote_count.compareTo(a.vote_count));
      items.add(ItemBean('knownfor',KnownForState(creditsModel:m)));
      var m2=state.creditsModel.clone();
      m2.cast=new List<CastData>()..addAll(m2.cast);
      m2.cast.sort((a,b){
        String date1=a.media_type=='movie'?a.release_date:a.first_air_date;
        String date2=b.media_type=='movie'?b.release_date:b.first_air_date;
        date1=date1==null||date1?.isEmpty==true?'2099-01-01':date1;
        date2=date2==null||date2?.isEmpty==true?'2099-01-01':date2;
        DateTime time1=DateTime.parse(date1);
        DateTime time2=DateTime.parse(date2);
        return time2.year==time1.year?
        (time2.month>time1.month?1:-1):
        (time2.year>time1.year?1:-1);
        });
      items.add(ItemBean('timeline',TimeLineState(creditsModel: m2, department: state.peopleDetailModel.known_for_department,showmovie: state.showmovie,scrollPhysics:PageScrollPhysics(parent:state.pageScrollPhysics))));
      items.add(ItemBean('personalinfo',PersonalInfoState(peopleDetailModel: state.peopleDetailModel,creditcount: state.creditsModel.cast.length+state.creditsModel.crew.length)));
    return items;
  }

  @override
  void set(PeopleDetailPageState state, List<ItemBean> items) {
    TimeLineState d=items[2].data;
    state.showmovie=d.showmovie;
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
