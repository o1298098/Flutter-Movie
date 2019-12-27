import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/peopledetail_page/components/gallery_component/component.dart';
import 'package:movie/views/peopledetail_page/components/header_component/component.dart';
import 'package:movie/views/peopledetail_page/components/knownfor_component/component.dart';
import 'package:movie/views/peopledetail_page/components/personalinfo_component/component.dart';
import 'package:movie/views/peopledetail_page/components/timeline_component/component.dart';

import '../state.dart';
import 'reducer.dart';

class PeopleAdapter extends SourceFlowAdapter<PeopleDetailPageState> {
  PeopleAdapter()
      : super(
          pool: <String, Component<Object>>{
            'header': HeaderComponent(),
            'knownfor': KnownForComponent(),
            'timeline': TimeLineComponent(),
            'personalinfo': PersonalInfoComponent(),
            'gallery': GalleryComponent(),
          },
          reducer: buildReducer(),
        );
}
