import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/episodedetail_page/components/credits_component/component.dart';
import 'package:movie/views/episodedetail_page/components/header_component/component.dart';
import 'package:movie/views/episodedetail_page/components/header_component/state.dart';
import 'package:movie/views/episodedetail_page/components/images_component/component.dart';

import 'components/credits_component/state.dart';
import 'components/images_component/state.dart';
import 'state.dart';

class EpisodeDetailAdapter extends SourceFlowAdapter<EpisodeDetailPageState> {
  EpisodeDetailAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header': EpisodeHeaderComponent(),
            'credits': CreditsComponent(),
            'images': ImagesComponent()
          },
        );
}
