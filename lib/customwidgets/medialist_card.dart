import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/listmediaitem.dart';
import 'package:movie/models/mylistmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediaListCardDialog extends StatefulWidget {
  final MediaType type;
  final int mediaId;
  MediaListCardDialog({@required this.type, @required this.mediaId});
  @override
  MediaListCardDialogState createState() => MediaListCardDialogState();
}

class MediaListCardDialogState extends State<MediaListCardDialog> {
  Future<MyListModel> lists;
  ScrollController scrollController;
  String _accountid;
  int _page;

  Future _loadMore() async {
    MyListModel model = await lists;
    if (model != null || _accountid == null) {
      int page = model.page + 1;
      if (page <= model.totalPages) {
        var r = await ApiHelper.getAccountListsV4(_accountid, page: page);
        if (r != null)
          setState(() {
            model.page = r.page;
            model.results.addAll(r.results);
          });
      }
    }
  }

  Future<MyListModel> _loadData() async {
    MyListModel list;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accountid = prefs.getString('accountIdV4');
    if (_accountid == null) {
      var token = await ApiHelper.createRequestTokenV4();
      if (token != null) {
        var url = 'https://www.themoviedb.org/auth/access?request_token=$token';
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'User Permission',
                style: TextStyle(color: Colors.black),
              ),
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: WebView(
              initialUrl: url,
            ),
          );
        }));
        var result = await ApiHelper.createAccessTokenV4(token);
        if (result)
          _accountid = prefs.getString('accountIdV4');
        else
          return null;
      }
    }
    var r = await ApiHelper.getAccountListsV4(_accountid);
    if (r != null) list = r;
    return list;
  }

  Future _submit() async {
    Navigator.of(context).pop();
    MyListModel model = await lists;
    if (model != null) {
      MyListResult selected = model.results?.singleWhere((f) => f.selected);
      if (selected != null) {
        List<ListMediaItem> items = List<ListMediaItem>()
          ..add(ListMediaItem(
              widget.type == MediaType.movie ? 'movie' : 'tv', widget.mediaId));
        var r = await ApiHelper.addToList(selected.id, items);
      }
    }
  }

  Widget _buildListCell(MyListResult d) {
    return Column(
      children: <Widget>[
        ListTile(
          selected: d.selected,
          title: Text(
            d.name,
            style: TextStyle(
                color: d.selected ? Colors.black : Colors.grey,
                fontSize: Adapt.px(30)),
          ),
          trailing: d.selected ? Icon(Icons.check) : null,
          onTap: () async {
            MyListModel all = await lists;
            setState(() {
              all.results.forEach((f) {
                if (f == d)
                  f.selected = !f.selected;
                else
                  f.selected = false;
              });
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
    lists = _loadData();
    scrollController = ScrollController()
      ..addListener(() async {
        bool isBottom = scrollController.position.pixels ==
            scrollController.position.maxScrollExtent;
        if (isBottom) await _loadMore();
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
                        fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.add_circle_outline)
                ],
              )),
          Divider(
            height: 2,
          ),
          Container(
            width: Adapt.screenW() - Adapt.px(60),
            height: Adapt.px(600),
            child: FutureBuilder<MyListModel>(
              future: lists,
              builder:
                  (BuildContext context, AsyncSnapshot<MyListModel> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container(
                      child: Center(
                        child: Text('No Result'),
                      ),
                    );
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
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    return ListView(
                      children:
                          snapshot.data.results.map(_buildListCell).toList(),
                    );
                }
                return null;
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
