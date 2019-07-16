import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/episodedetail_page/components/credits_component/component.dart';
import 'package:movie/views/episodedetail_page/components/header_component/component.dart';
import 'package:movie/views/episodedetail_page/components/header_component/state.dart';
import 'package:movie/views/episodedetail_page/components/images_component/component.dart';

import 'components/credits_component/state.dart';
import 'components/images_component/state.dart';
import 'state.dart';

class EpisodeDetailAdapter extends DynamicFlowAdapter<EpisodeDetailPageState> {
  EpisodeDetailAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header':EpisodeHeaderComponent(),
            'credits':CreditsComponent(),
            'images':ImagesComponent()
          },
          connector: _EpisodeDetailConnector(),
          );
}

class _EpisodeDetailConnector extends ConnOp<EpisodeDetailPageState, List<ItemBean>> {
  @override
  List<ItemBean> get(EpisodeDetailPageState state) {
    List<ItemBean> items=<ItemBean>[];
    items.add(ItemBean('header',EpisodeHeaderState(episode:  state.episode)));
    items.add(ItemBean('credits',CreditsState(guestStars: state.episode?.credits?.guest_stars,crew: state.episode?.credits?.crew)));
    items.add(ItemBean('images',ImagesState(images: state.episode?.images)));
    return items;
  }

  @override
  void set(EpisodeDetailPageState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
