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
    items.add(ItemBean('knownfor', KnownForState(cast: state.knowForCast)));
    items.add(ItemBean(
        'timeline',
        TimeLineState(
            creditsModel: state.creditsModel,
            department: state.peopleDetailModel.known_for_department,
            showmovie: state.showmovie,
            scrollPhysics:
                PageScrollPhysics(parent: state.pageScrollPhysics))));
    items.add(ItemBean(
        'personalinfo',
        PersonalInfoState(
            peopleDetailModel: state.peopleDetailModel,
            creditcount: state.creditsModel.cast.length +
                state.creditsModel.crew.length)));
    return items;
  }

  @override
  void set(PeopleDetailPageState state, List<ItemBean> items) {
    TimeLineState d = items[2].data;
    state.showmovie = d.showmovie;
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
