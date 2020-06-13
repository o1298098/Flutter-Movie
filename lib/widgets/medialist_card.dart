import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/base_api.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/user_list.dart';
import 'package:movie/models/base_api_model/user_list_detail.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/mylistmodel.dart';

class MediaListCardDialog extends StatefulWidget {
  final MediaType type;
  final int mediaId;
  final String name;
  final double rated;
  final String photourl;
  final int runtime;
  final int revenue;
  final String releaseDate;
  MediaListCardDialog(
      {@required this.type,
      @required this.mediaId,
      this.name,
      this.rated,
      this.photourl,
      this.runtime = 0,
      this.revenue = 0,
      this.releaseDate});
  @override
  MediaListCardDialogState createState() => MediaListCardDialogState();
}

class MediaListCardDialogState extends State<MediaListCardDialog> {
  Future<MyListModel> lists;
  ScrollController scrollController;
  Future<UserListModel> _userList;

  final _user = GlobalStore.store.getState().user;

  initUserlist() {
    if (_user != null)
      setState(() {
        _userList = BaseApi.getUserList(_user.firebaseUser.uid);
      });
  }

  void _createList(String name, String description) {
    if (_user != null) {
      setState(() {
        _userList = null;
      });
      BaseApi.createUserList(UserList.fromParams(
              uid: _user.firebaseUser.uid,
              listName: name,
              description: description,
              backGroundUrl: ImageUrl.getUrl(widget.photourl, ImageSize.w300)))
          .then((d) => initUserlist());

      Navigator.pop(context);
    }
  }

  Future _submit() async {
    final _list = await _userList;
    Navigator.of(context).pop();
    String _mediaType = widget.type == MediaType.movie ? 'movie' : 'tv';
    if (_user != null && _list != null) {
      var d = _list.data.singleWhere((f) => f.selected == 1);
      if (d != null) {
        var item = await BaseApi.getUserListDetailItem(
            d.id, _mediaType, widget.mediaId);
        if (item == null) {
          d.totalRated += widget.rated;
          d.runTime += widget.runtime;
          d.itemCount += 1;
          d.revenue += widget.revenue;
          await BaseApi.updateUserList(d);
          await BaseApi.addUserListDetail(UserListDetail.fromParams(
              mediaid: widget.mediaId,
              mediaName: widget.name,
              mediaType: _mediaType,
              rated: widget.rated,
              runTime: widget.runtime,
              revenue: double.parse(widget.revenue?.toString() ?? '0.0'),
              photoUrl: widget.photourl,
              listid: d.id));
        }
      }
    }
  }

  void _buildCreateListDialog() {
    String _name = '';
    String _description = '';
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Adapt.px(30))),
            contentPadding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(Adapt.px(30)),
                width: Adapt.px(600),
                height: Adapt.screenH() / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ListName',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (s) => _name = s,
                    ),
                    SizedBox(
                      height: Adapt.px(30),
                    ),
                    TextField(
                      maxLines: 12,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'description',
                          labelStyle: TextStyle(fontSize: Adapt.px(24)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      onChanged: (s) => _description = s,
                    ),
                    SizedBox(
                      height: Adapt.px(30),
                    ),
                    FlatButton(
                      color: Color(0xFF505050),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Adapt.px(20))),
                      onPressed: () => _createList(_name, _description),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white, fontSize: Adapt.px(28)),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  Widget _buildListCell(UserList d) {
    bool _selected = d.selected == 1 ? true : false;
    return Column(
      children: <Widget>[
        ListTile(
          selected: _selected,
          title: Text(
            d.listName,
            style: TextStyle(fontSize: Adapt.px(30)),
          ),
          trailing: _selected ? Icon(Icons.check) : SizedBox(),
          onTap: () async {
            final l = await _userList;
            l.data.forEach((f) {
              if (f.selected == 1) f.selected = 0;
            });
            d.selected = 1;
            setState(() {});
          },
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  @override
  void initState() {
    initUserlist();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Adapt.px(20))),
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Add to my list',
                    style: TextStyle(
                        fontSize: Adapt.px(40), fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: _buildCreateListDialog,
                  )
                ],
              )),
          Divider(
            height: 2,
          ),
          Container(
            width: Adapt.screenW() - Adapt.px(60),
            height: Adapt.px(600),
            child: FutureBuilder<UserListModel>(
              future: _userList,
              builder: (BuildContext context,
                  AsyncSnapshot<UserListModel> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Container(
                      margin: EdgeInsets.only(top: Adapt.px(30)),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasData)
                      return ListView(
                        children:
                            snapshot.data.data.map(_buildListCell).toList(),
                      );
                    else
                      return SizedBox();
                }
                return SizedBox();
              },
            ),
          ),
          Divider(),
          Container(
            height: Adapt.px(100),
            child: FlatButton(
              child: Text(
                'Submit',
                style:
                    TextStyle(color: Colors.blueAccent, fontSize: Adapt.px(35)),
              ),
              onPressed: _submit,
            ),
          )
        ]);
  }
}
