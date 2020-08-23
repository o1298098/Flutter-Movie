import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/discover_page/components/movicecell_component/component.dart';
import 'state.dart';

class DiscoverListAdapter extends SourceFlowAdapter<DiscoverPageState> {
  DiscoverListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'moviecell': MovieCellComponent(),
          },
        );
}
