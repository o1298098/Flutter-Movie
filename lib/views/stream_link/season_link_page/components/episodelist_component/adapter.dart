import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/stream_link/season_link_page/components/episode_component/component.dart';
import 'state.dart';

class EpisodeListAdapter extends SourceFlowAdapter<EpisodeListState> {
  EpisodeListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'episode': EpisodeComponent(),
          },
        );
}
