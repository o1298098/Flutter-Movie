import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/listdetail_page/components/header_component/state.dart';
import 'package:movie/views/listdetail_page/components/infogroup_component/component.dart';

import 'components/body_component/component.dart';
import 'components/body_component/state.dart';
import 'components/header_component/component.dart';
import 'components/infogroup_component/state.dart';
import 'components/sharecard_component/component.dart';
import 'components/sharecard_component/state.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListDetailPage extends Page<ListDetailPageState, Map<String, dynamic>> {
  ListDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ListDetailPageState>(
              adapter: null,
              slots: <String, Dependent<ListDetailPageState>>{
                'header': HeaderConnector() + HeaderComponent(),
                'infoGroup': InfoGroupConnector() + InfoGroupComponent(),
                'shareCard': ShareCardConnector() + ShareCardComponent(),
                'body': BodyConnector() + BodyComponent(),
              }),
          middleware: <Middleware<ListDetailPageState>>[],
        );
}
