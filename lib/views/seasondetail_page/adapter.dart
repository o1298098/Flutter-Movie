import 'package:fish_redux/fish_redux.dart';

import 'components/episodes_component/component.dart';
import 'components/header_component/component.dart';
import 'components/seasoncast_component/component.dart';
import 'state.dart';

class SeasonDetailAdapter extends SourceFlowAdapter<SeasonDetailPageState> {
  SeasonDetailAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header': HeaderComponent(),
            'seasonCast': SeasonCastComponent(),
            'episodes': EpisodesComponent()
          },
        );
}
