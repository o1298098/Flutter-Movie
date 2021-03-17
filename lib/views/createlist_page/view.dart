import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/loading_layout.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateListPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      return Stack(
        children: [
          Scaffold(
            backgroundColor: _theme.backgroundColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              iconTheme: _theme.iconTheme,
              elevation: 0.0,
              backgroundColor: _theme.backgroundColor,
              title: Text(
                'CreatList',
                style: _theme.textTheme.bodyText1,
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      dispatch(CreateListPageActionCreator.onSubmit()),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: _theme.textTheme.bodyText1.color, fontSize: 16),
                  ),
                )
              ],
            ),
            body: _Body(
              backGroundUrl: state.backGroundUrl,
              descriptionTextController: state.descriptionTextController,
              listData: state.listData,
              nameTextController: state.nameTextController,
              dispatch: dispatch,
              nameFoucsNode: state.nameFoucsNode,
              descriptionFoucsNode: state.descriptionFoucsNode,
              onUploadImage: () =>
                  dispatch(CreateListPageActionCreator.uploadBackground()),
            ),
          ),
          LoadingLayout(
            title: 'loading...',
            show: state.loading,
          )
        ],
      );
    },
  );
}

class _Body extends StatelessWidget {
  final TextEditingController nameTextController;
  final String backGroundUrl;
  final TextEditingController descriptionTextController;
  final FocusNode nameFoucsNode;
  final FocusNode descriptionFoucsNode;
  final UserList listData;
  final Dispatch dispatch;
  final Function onUploadImage;
  _Body({
    this.backGroundUrl,
    this.descriptionTextController,
    this.dispatch,
    this.listData,
    this.nameTextController,
    this.descriptionFoucsNode,
    this.nameFoucsNode,
    this.onUploadImage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _CustomTextField(
            title: 'Name',
            controller: nameTextController,
            focusNode: nameFoucsNode,
          ),
          _BackGroundUpLoad(
            url: backGroundUrl,
            onTap: onUploadImage,
          ),
          _CustomTextField(
            title: 'Description',
            controller: descriptionTextController,
            focusNode: descriptionFoucsNode,
            maxLines: 12,
          ),
        ],
      ),
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
