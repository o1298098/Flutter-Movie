import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/seasondetail_page/components/episodes_component/component.dart';
import 'package:movie/views/seasondetail_page/components/seasoncast_component/component.dart';
import 'package:movie/views/seasondetail_page/components/seasoncrew_component/component.dart';

import 'components/episodes_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/seasoncast_component/state.dart';
import 'components/seasoncrew_component/state.dart';
import 'state.dart';

class SeasonDetailAdapter extends DynamicFlowAdapter<SeasonDetailPageState> {
  SeasonDetailAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header': HeaderComponent(),
            'seasonCast': SeasonCastComponent(),
            'seasonCrew': SeasonCrewComponent(),
            'episodes': EpisodesComponent()
          },
          connector: _SeasonDetailConnector(),
        );
}

class _SeasonDetailConnector
    extends ConnOp<SeasonDetailPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(SeasonDetailPageState state) {
    List<ItemBean> items = List<ItemBean>();
    items.add(ItemBean(
        'header',
        HeaderState(
            name: state.name,
            posterurl: state.seasonpic,
            airDate: state.seasonDetailModel.air_date,
            overwatch: state.seasonDetailModel.overview)));
    items.add(ItemBean('seasonCast', state.seasonCastState));
    items.add(ItemBean('seasonCrew', SeasonCrewState()));
    items.add(ItemBean('episodes', EpisodesState(episodes: state.seasonDetailModel.episodes,tvid: state.tvid)));
    return items;
  }

  @override
  void set(SeasonDetailPageState state, List<ItemBean> items) {
    SeasonCastState castState = items[1].data;
    EpisodesState episodesState=items[3].data;
    state.seasonCastState = castState;
    state.seasonDetailModel.episodes=episodesState.episodes;
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
