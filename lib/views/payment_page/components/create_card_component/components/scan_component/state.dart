import 'package:camera/camera.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/payment_page/components/create_card_component/state.dart';

class ScanState implements Cloneable<ScanState> {
  CameraController controller;
  @override
  ScanState clone() {
    return ScanState()..controller = controller;
  }
}

class ScanConnector extends ConnOp<CreateCardState, ScanState> {
  @override
  ScanState get(CreateCardState state) {
    ScanState mstate = state.scanState;
    return mstate;
  }

  @override
  void set(CreateCardState state, ScanState subState) {
    state.scanState = subState;
  }
}
