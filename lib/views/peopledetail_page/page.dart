import 'package:fish_redux/fish_redux.dart';

import 'components/gallery_component/component.dart';
import 'components/gallery_component/state.dart';
import 'components/header_component/component.dart';
import 'components/header_component/state.dart';
import 'components/knownfor_component/component.dart';
import 'components/knownfor_component/state.dart';
import 'components/personalinfo_component/component.dart';
import 'components/personalinfo_component/state.dart';
import 'components/timeline_component/component.dart';
import 'components/timeline_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PeopleDetailPage
    extends Page<PeopleDetailPageState, Map<String, dynamic>> {
  PeopleDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PeopleDetailPageState>(
              adapter: null,
              slots: <String, Dependent<PeopleDetailPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'personalInfo':
                    PersonalInfoConnector() + PersonalInfoComponent(),
                'knowFor': KnownForConnector() + KnownForComponent(),
                'gallery': GalleryConnector() + GalleryComponent(),
                'timeline': TimeLineConnector() + TimeLineComponent(),
              }),
          middleware: <Middleware<PeopleDetailPageState>>[],
        );
}
