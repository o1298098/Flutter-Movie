import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movie/views/account_page/state.dart';

class DataPanelState implements Cloneable<DataPanelState> {
  List<DownloadTask> downloadTask;
  @override
  DataPanelState clone() {
    return DataPanelState()..downloadTask = downloadTask;
  }
}

class DataPanelConnector extends ConnOp<AccountState, DataPanelState> {
  @override
  DataPanelState get(AccountState state) {
    DataPanelState substate = DataPanelState();
    substate.downloadTask = state.dataPanelState.downloadTask;
    return substate;
  }

  @override
  void set(AccountState state, DataPanelState subState) {
    state.dataPanelState = subState;
  }
}
