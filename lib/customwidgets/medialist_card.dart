import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/listmediaitem.dart';
import 'package:movie/models/mylistmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  String _accountid;
  List<DocumentSnapshot> _documents;
  int _page;

  final _user = GlobalStore.store.getState().user;

  void _createList(String name, String description) {
    if (_user != null) {
      Firestore.instance
          .collection("MyList")
          .document(_user.uid)
          .collection('List')
          .document(name)
          .setData({
        'description': description,
        'backGroundUrl': '',
        'selected': false,
        'createDateTime': DateTime.now(),
        'updateDateTime': DateTime.now(),
        'itemCount': 0,
        'totalRated': 0.0,
        'runTime': 0,
        'revenue': 0
      });
      Navigator.pop(context);
    }
  }

  Future _submit() async {
    Navigator.of(context).pop();
    String _mediaType = widget.type == MediaType.movie ? 'movie' : 'tv';
    if (_user != null && _documents != null) {
      var d = _documents.singleWhere((f) => f['selected']);

      if (d.data != null) {
        var item = await d.reference
            .collection('Media')
            .document('$_mediaType${widget.mediaId}')
            .get();
        if (item?.data == null) {
          d.reference.updateData({
            'totalRated': d['totalRated'] + widget.rated,
            'runTime': d['runTime'] + widget.runtime,
            'itemCount': d['itemCount'] + 1,
            'revenue': d['revenue'] + widget.revenue,
            'updateDateTime': DateTime.now(),
          });
          d.reference
              .collection('Media')
              .document('$_mediaType${widget.mediaId}')
              .setData({
            'id': widget.mediaId,
            'name': widget.name,
            'mediaType': _mediaType,
            'rated': widget.rated,
            'photourl': widget.photourl,
            'releaseDate': widget.releaseDate
          });
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

  Widget _buildListCell(DocumentSnapshot d) {
    bool _selected = d['selected'] ?? false;
    return Column(
      children: <Widget>[
        ListTile(
          selected: _selected,
          title: Text(
            d.documentID,
            style: TextStyle(fontSize: Adapt.px(30)),
          ),
          trailing: _selected ? Icon(Icons.check) : SizedBox(),
          onTap: () async {
            _documents.forEach((f) {
              if (f['selected']) f.reference.updateData({'selected': false});
              d.reference.updateData({'selected': !_selected});
            });
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
    scrollController = ScrollController()
      ..addListener(() async {
        bool isBottom = scrollController.position.pixels ==
            scrollController.position.maxScrollExtent;
      });
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
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('MyList')
                  .document(_user.uid)
                  .collection('List')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    margin: EdgeInsets.only(top: Adapt.px(30)),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                    ),
                  );
                _documents = snapshot.data.documents;
                return ListView(
                  children:
                      snapshot.data.documents.map(_buildListCell).toList(),
                );
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
