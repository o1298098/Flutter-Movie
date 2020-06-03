import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:path_provider/path_provider.dart';
import 'action.dart';
import 'state.dart';

Effect<ScanState> buildEffect() {
  return combineEffects(<Object, Effect<ScanState>>{
    ScanAction.action: _onAction,
    ScanAction.takePicture: _takePicture,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<ScanState> ctx) {}

final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();
void _takePicture(Action action, Context<ScanState> ctx) async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/flutter_test';
  await Directory(dirPath).create(recursive: true);
  final String filePath =
      '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
  ctx.state.controller.takePicture(filePath).then((value) {
    final _image = FirebaseVisionImage.fromFilePath(filePath);
    _recognizer.processImage(_image).then((d) {
      print(d.text);
    });
  });
  /*ctx.state.controller.startImageStream((image) {
    FirebaseVisionImage.fromBytes(
        image.planes[0].bytes,
        FirebaseVisionImageMetadata(
            planeData: [],
            rawFormat: image.format.raw,
            size: Size(image.width.toDouble(), image.height.toDouble())));
  });*/
}

void _onInit(Action action, Context<ScanState> ctx) async {
  final _cameras = await availableCameras();
  if (_cameras.length > 0) {
    final _controller = CameraController(_cameras[0], ResolutionPreset.medium);
    _controller..initialize();
    ctx.dispatch(ScanActionCreator.updateController(_controller));
  }
}

void _onDispose(Action action, Context<ScanState> ctx) {
  ctx.state.controller?.dispose();
}
