import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(ScanState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(),
    body: Column(
      children: [
        state.controller != null
            ? AspectRatio(
                aspectRatio: state.controller.value.aspectRatio,
                child: CameraPreview(state.controller))
            : SizedBox(),
        TextButton(
            onPressed: () => dispatch(ScanActionCreator.takePicture()),
            child: Text('take a picture'))
      ],
    ),
  );
}
