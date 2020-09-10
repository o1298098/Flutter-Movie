import 'package:camera/camera.dart';
import 'package:fish_redux/fish_redux.dart';

enum ScanAction { action, updateController, takePicture }

class ScanActionCreator {
  static Action onAction() {
    return const Action(ScanAction.action);
  }

  static Action updateController(CameraController controller) {
    return Action(ScanAction.updateController, payload: controller);
  }

  static Action takePicture() {
    return const Action(ScanAction.takePicture);
  }
}
