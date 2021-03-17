import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie/actions/api/graphql_client.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/loading_layout.dart';
import 'package:path/path.dart' as Path;
import 'package:toast/toast.dart';

class CastListCreate extends StatefulWidget {
  final BaseCastList data;
  const CastListCreate({this.data});
  @override
  _CastListCreateState createState() => _CastListCreateState();
}

class _CastListCreateState extends State<CastListCreate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameFoucsNode = FocusNode();
  final FocusNode _descriptionFoucsNode = FocusNode();
  bool _editMode = false;
  bool _loading = false;
  String _url;
  void _onSave() async {
    _nameFoucsNode.unfocus();
    _descriptionFoucsNode.unfocus();
    if (_nameController.text == "")
      return Toast.show('List name can\'t be empty', context);
    final _user = GlobalStore.store.getState().user;
    if (_user?.firebaseUser == null)
      return Toast.show('Please login before add a list', context);
    _setLoading(true);
    final _nowTime = DateTime.now();
    QueryResult _result;
    if (!_editMode) {
      final _list = BaseCastList.fromParams(
        uid: _user.firebaseUser.uid,
        name: _nameController.text,
        description: _descriptionController.text,
        backgroundUrl: _url,
        createTime: _nowTime,
        updateTime: _nowTime,
      );
      _result = await BaseGraphQLClient.instance.addCastList(_list);
    } else {
      final _list = BaseCastList.fromParams(
          id: widget.data.id,
          uid: widget.data.uid,
          name: _nameController.text,
          description: _descriptionController.text,
          backgroundUrl: _url,
          createTime: widget.data.createTime,
          updateTime: _nowTime,
          castCount: widget.data.castCount);
      _result = await BaseGraphQLClient.instance.updateCastList(_list);
    }
    _setLoading(false);
    if (!_result.hasException)
      Navigator.of(context).pop();
    else {
      Toast.show('Something wrong', context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _nameFoucsNode.dispose();
    _descriptionFoucsNode.dispose();
    super.dispose();
  }

  void _onUploadImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final _image = await _imagePicker.getImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    if (_image != null) {
      _setLoading(true);
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('avatar/${Path.basename(_image.path)}');
      StorageUploadTask uploadTask =
          storageReference.putData(await _image.readAsBytes());
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        if (fileURL != null) {
          setState(() {
            _url = fileURL;
          });
        }
      });
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    if (_loading == loading) return;
    setState(() {
      _loading = loading;
    });
  }

  void _deleteCastList() async {
    _setLoading(true);
    final _result =
        await BaseGraphQLClient.instance.deleteCastList(widget.data.id);

    _setLoading(false);
    if (!_result.hasException)
      Navigator.of(context).pop();
    else {
      Toast.show('Something wrong', context);
    }
  }

  @override
  void initState() {
    if (widget.data != null) {
      _editMode = true;
      _nameController.text = widget.data.name;
      _url = widget.data.backgroundUrl;
      _descriptionController.text = widget.data.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: _theme.backgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              '${_editMode ? 'Edit' : 'Create'} Cast List',
              style: TextStyle(color: _theme.textTheme.bodyText1.color),
            ),
            iconTheme: _theme.iconTheme,
            backgroundColor: _theme.backgroundColor,
            actions: [
              TextButton(
                onPressed: _onSave,
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: _theme.textTheme.bodyText1.color, fontSize: 16),
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                _CustomTextField(
                  title: 'Name',
                  controller: _nameController,
                  focusNode: _nameFoucsNode,
                ),
                _BackGroundUpLoad(
                  url: _url,
                  onTap: _onUploadImage,
                ),
                _CustomTextField(
                  title: 'Description',
                  controller: _descriptionController,
                  focusNode: _descriptionFoucsNode,
                  maxLines: 12,
                ),
                Spacer(),
                _editMode
                    ? GestureDetector(
                        onTap: _deleteCastList,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF0000),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'DELETE',
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
        LoadingLayout(title: 'loading...', show: _loading)
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String title;
  final double width;
  final int maxLines;
  final FocusNode focusNode;
  final TextEditingController controller;
  const _CustomTextField(
      {this.title,
      this.width,
      this.maxLines = 1,
      this.controller,
      this.focusNode});
  @override
  Widget build(BuildContext context) {
    final double _fontSize = 20;
    final Size _size = MediaQuery.of(context).size;
    final _intputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: const Color(0xFF9E9E9E)));
    return Container(
      width: width ?? _size.width,
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: _fontSize)),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            maxLines: maxLines,
            focusNode: focusNode,
            cursorColor: const Color(0xFF9E9E9E),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              enabledBorder: _intputBorder,
              disabledBorder: _intputBorder,
              focusedBorder: _intputBorder,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackGroundUpLoad extends StatelessWidget {
  final String url;
  final Function onTap;
  const _BackGroundUpLoad({this.onTap, this.url});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Background', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF9E9E9E))),
              child: Row(
                children: [
                  SizedBox(
                    width: _size.width - 120,
                    child: Text(
                      url ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _theme.iconTheme.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.file_upload,
                      color: _theme.accentIconTheme.color,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
