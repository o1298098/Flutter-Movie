import 'package:firebase_storage/firebase_storage.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:path/path.dart' as Path;
import 'action.dart';
import 'state.dart';

Effect<CreateListPageState> buildEffect() {
  return combineEffects(<Object, Effect<CreateListPageState>>{
    CreateListPageAction.action: _onAction,
    CreateListPageAction.submit: _submit,
    CreateListPageAction.uploadBackground: _uploadBackground,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<CreateListPageState> ctx) {}
void _onInit(Action action, Context<CreateListPageState> ctx) {
  ctx.state.nameTextController = TextEditingController(text: ctx.state.name);
  ctx.state.descriptionTextController =
      TextEditingController(text: ctx.state.description);
}

void _onDispose(Action action, Context<CreateListPageState> ctx) async {
  ctx.state.nameTextController?.dispose();
  ctx.state.descriptionTextController?.dispose();
  ctx.state.nameFoucsNode?.dispose();
  ctx.state.descriptionFoucsNode?.dispose();
}

void _submit(Action action, Context<CreateListPageState> ctx) {
  ctx.state.nameFoucsNode.unfocus();
  ctx.state.descriptionFoucsNode.unfocus();
  final _baseApi = BaseApi.instance;
  if (ctx.state.user != null) {
    if (ctx.state.listData != null)
      _baseApi.updateUserList(ctx.state.listData
        ..backGroundUrl = ctx.state.backGroundUrl
        ..description = ctx.state.descriptionTextController.text);
    else {
      final _date = DateTime.now().toString();
      ctx.state.listData = UserList.fromParams(
        uid: ctx.state.user.firebaseUser.uid,
        listName: ctx.state.nameTextController.text,
        backGroundUrl: ctx.state.backGroundUrl,
        description: ctx.state.descriptionTextController.text,
        createTime: _date,
        updateTime: _date,
        revenue: 0,
        runTime: 0,
        itemCount: 0,
        totalRated: 0,
      );
      _baseApi.createUserList(ctx.state.listData);
    }

    Navigator.of(ctx.context).pop(ctx.state.listData);
  }
}

void _uploadBackground(Action action, Context<CreateListPageState> ctx) async {
  final ImagePicker _imagePicker = ImagePicker();
  final _image = await _imagePicker.getImage(
      source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
  if (_image != null) {
    ctx.dispatch(CreateListPageActionCreator.setLoading(true));
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('avatar/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask =
        storageReference.putData(await _image.readAsBytes());
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      if (fileURL != null) {
        ctx.dispatch(CreateListPageActionCreator.setBackground(fileURL));
      }
    });
    ctx.dispatch(CreateListPageActionCreator.setLoading(false));
  }
}
