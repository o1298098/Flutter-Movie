import 'package:fish_redux/fish_redux.dart';
import 'components/episodelist_component/component.dart';
import 'state.dart';

class TabViewAdapter extends SourceFlowAdapter<SeasonLinkPageState> {
  TabViewAdapter()
      : super(
          pool: <String, Component<Object>>{
            'listview': EpisodeListComponent(),
          },
        );
}
